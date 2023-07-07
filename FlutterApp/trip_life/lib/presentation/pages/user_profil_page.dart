import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_friend_repository.dart';
import 'package:trip_life/application/blocs/user_profil_bloc/user_profil_bloc.dart';
import 'package:trip_life/presentation/service_locator.dart';
import 'package:trip_life/presentation/widgets/shared/retry_scaffold.dart';
import 'package:trip_life/presentation/widgets/user/user_profil_scaffold.dart';

class UserProfilPage extends StatefulWidget {
  const UserProfilPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const UserProfilPage());
  }

  @override
  State<UserProfilPage> createState() => _UserProfilPageState();
}

class _UserProfilPageState extends State<UserProfilPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserProfilBloc(
          friendRepository: serviceLocator.get<AbstractFriendRepository>())
        ..add(UserProfilRequest()),
      child: BlocConsumer<UserProfilBloc, UserProfilState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status.isSuccessful) {
            return UserProfilScaffold(connectedUser: state.connectedUser!);
          } else if (state.status.isFailed) {
            return RetryScaffold(
                errorMessage: state.errorMessage,
                callback: () {
                  context.read<UserProfilBloc>().add(UserProfilRequest());
                });
          }
          return const Scaffold(
              body: Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.green)));
        },
      ),
    );
  }
}
