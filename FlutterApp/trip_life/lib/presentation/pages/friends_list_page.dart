import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/blocs/friend_list_bloc/friend_list_bloc.dart';
import 'package:trip_life/presentation/pages/add_friend_page.dart';
import 'package:trip_life/presentation/widgets/friend/friend_list.dart';
import 'package:trip_life/presentation/widgets/shared/app_bar/main_app_bar.dart';
import 'package:trip_life/presentation/widgets/shared/main_drawer.dart';

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
      body: const FriendsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddFriendPage,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddFriendPage() async {
    await Navigator.of(context).push(AddFriendPage.route());
    context.read<FriendListBloc>().add(FriendListRequest());
  }
}
