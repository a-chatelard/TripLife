import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:trip_life/application/blocs/signup_bloc/signup_bloc.dart';
import 'package:trip_life/presentation/widgets/shared/forms/email_textformfield.dart';
import 'package:trip_life/presentation/widgets/shared/forms/password_textformfield.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupBloc, SignupState>(listener: (context, state) {
      if (state.status.isSuccessful) {
        context
            .read<AuthenticationBloc>()
            .add(DetermineAppUserAuthentication());
      }
    }, builder: (context, state) {
      return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                    hintText: 'Saississez votre nom d\'utilisateur')),
            const SizedBox(height: 20),
            EmailTextFormField(
                hintText: 'Saississez votre email',
                textEditingController: _emailController),
            const SizedBox(height: 20),
            PasswordTextFormField(
                hintText: 'Entrez votre mot de passe',
                textEditingController: _passwordController),
            const SizedBox(height: 20),
            PasswordTextFormField(
                hintText: 'Confirmez votre mot de passe',
                textEditingController: _confirmPasswordController),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  context.read<SignupBloc>().add(SignupRequested(
                      _usernameController.text,
                      _emailController.text,
                      _passwordController.text));
                },
                child: const Text('Valider'))
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }
}
