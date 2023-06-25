import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:trip_life/application/blocs/signin_bloc/signin_bloc.dart';
import 'package:trip_life/presentation/widgets/shared/forms/email_textformfield.dart';
import 'package:trip_life/presentation/widgets/shared/forms/password_textformfield.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({super.key});

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? validatePasseword(String? value) {
    if (value == null || value.isEmpty) {
      return "Veuillez saisir un mot de passe";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninBloc, SigninState>(listener: (context, state) {
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
            EmailTextFormField(
                hintText: 'Email', textEditingController: _emailController),
            const SizedBox(height: 20),
            PasswordTextFormField(
              hintText: 'Mot de passe',
              textEditingController: _passwordController,
              valitor: validatePasseword,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<SigninBloc>().add(SigninRequested(
                        _emailController.text, _passwordController.text));
                  }
                },
                child: const Text('Connexion'))
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
