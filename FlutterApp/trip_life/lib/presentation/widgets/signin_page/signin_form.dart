import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:trip_life/application/blocs/signin_bloc/signin_bloc.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({super.key});

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninBloc, SigninState>(listener: (context, state) {
      if (state.status.isSuccessful) {
        context
            .read<AuthenticationBloc>()
            .add(DetermineAppUserAuthentication());
      }
    }, builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(hintText: 'Email'),
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(hintText: 'Password'),
          ),
          ElevatedButton(
              onPressed: () {
                context.read<SigninBloc>().add(SigninRequested(
                    _emailController.value.toString(),
                    _passwordController.value.toString()));
              },
              child: const Text('Login In'))
        ],
      );
    });
  }
}
