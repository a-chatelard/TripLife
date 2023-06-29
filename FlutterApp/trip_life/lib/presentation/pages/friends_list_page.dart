import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_friend_repository.dart';
import 'package:trip_life/application/blocs/friend_list_bloc/friend_list_bloc.dart';
import 'package:trip_life/presentation/pages/add_friend_page.dart';
import 'package:trip_life/presentation/service_locator.dart';
import 'package:trip_life/presentation/widgets/friend/friend_list_item.dart';
import 'package:trip_life/presentation/widgets/shared/main_app_bar.dart';
import 'package:trip_life/presentation/widgets/shared/main_drawer.dart';
import 'package:trip_life/presentation/widgets/shared/retry_scaffold.dart';

class FriendsListPage extends StatefulWidget {
  const FriendsListPage({super.key, required this.title});

  final String title;

  static Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (_) => const FriendsListPage(
              title: "Mes amis",
            ));
  }

  @override
  State<FriendsListPage> createState() => _FriendsListPageState();
}

class _FriendsListPageState extends State<FriendsListPage> {
  final String title = "Mes amis";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: title),
      drawer: const MainDrawer(),
      body: BlocProvider(
          create: (_) => FriendListBloc(
              friendRepository: serviceLocator.get<AbstractFriendRepository>()),
          child: BlocConsumer<FriendListBloc, FriendListState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state.status.isSuccessful) {
                  return ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: state.friendList?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return FriendListItem(
                            username: state.friendList?[index].username ?? "");
                      });
                } else if (state.status.isFailed) {
                  return RetryScaffold(
                      errorMessage: state.errorMessage,
                      callback: () {
                        context
                            .read<FriendListBloc>()
                            .emit(const FriendListState.loading());
                        context.read<FriendListBloc>().add(FriendListRequest());
                      });
                } else {
                  return const Scaffold(
                      body: Center(
                          child: CircularProgressIndicator(
                              backgroundColor: Colors.green)));
                }
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddFriendPage,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddFriendPage() {
    Navigator.of(context).push(AddFriendPage.route());
  }
}
