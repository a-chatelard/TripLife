import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_authentication_repository.dart';
import 'package:trip_life/application/blocs/signup_bloc/signup_bloc.dart';
import 'package:trip_life/presentation/service_locator.dart';
import 'package:trip_life/presentation/widgets/shared/clickable_text_span.dart';
import 'package:trip_life/presentation/widgets/signup/signup_form.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key, required this.title});

  static Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (_) => const SignupPage(title: "Inscription"));
  }

  final String title;

  @override
  State<SignupPage> createState() => _SignupState();
}

class _SignupState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => SignupBloc(
            authenticationRepository:
                serviceLocator.get<AbstractAuthenticationRepository>()),
        child: Scaffold(
          body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SignupForm(),
                const SizedBox(height: 20),
                Text.rich(ClickableTextSpan("Se connecter", () {
                  Navigator.of(context).pop();
                })),
              ],
            ),
          ),
        ));
  }
}
