import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:trip_life/entity/models/connected_user.dart';
import 'package:trip_life/presentation/widgets/shared/app_bar/previous_screen_app_bar.dart';

class UserProfilScaffold extends StatelessWidget {
  const UserProfilScaffold({super.key, required this.connectedUser});

  final ConnectedUser connectedUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreviousScreenAppBar(),
        body: Column(
          children: [
            Text("Pseudo : ${connectedUser.username}"),
            Text("Email : ${connectedUser.email}"),
            TextButton(
              onPressed: () {
                context
                    .read<AuthenticationBloc>()
                    .add(LogOutUserAuthentication());
              },
              child: const Text("Déconnexion"),
            )
          ],
        ));
  }
}
