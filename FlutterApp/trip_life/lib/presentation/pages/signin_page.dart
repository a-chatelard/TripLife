import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_authentication_repository.dart';
import 'package:trip_life/application/blocs/signin_bloc/signin_bloc.dart';
import 'package:trip_life/presentation/service_locator.dart';
import 'package:trip_life/presentation/widgets/signin_page/signin_form.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key, required this.title});

  static Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (_) => const SignInPage(title: "Connexion"));
  }

  final String title;

  @override
  State<SignInPage> createState() => _SignInState();
}

class _SignInState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => SigninBloc(
            authenticationRepository:
                serviceLocator.get<AbstractAuthenticationRepository>()),
        child: Scaffold(
          body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: const SigninForm(),
          ),
        ));
  }
}
