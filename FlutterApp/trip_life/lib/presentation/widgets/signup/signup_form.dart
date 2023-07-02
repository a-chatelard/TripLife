import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/blocs/signup_bloc/signup_bloc.dart';
import 'package:trip_life/presentation/widgets/shared/forms/email_textformfield.dart';
import 'package:trip_life/presentation/widgets/shared/forms/password_textformfield.dart';
import 'package:trip_life/presentation/widgets/shared/overlay_entry/loader_overlay_entry.dart';
import 'package:trip_life/presentation/widgets/shared/overlay_entry/success_overlay_entry.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  late AnimationController checkController = AnimationController(
      duration: const Duration(milliseconds: 400), vsync: this);
  late Animation<double> checkAnimation =
      CurvedAnimation(parent: checkController, curve: Curves.linear);

  late OverlayEntry? overlayEntry = LoaderOverlayEntry.build();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupBloc, SignupState>(listener: (context, state) {
      if (state.status.isLoading) {
        Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
      } else if (state.status.isSuccessful) {
        overlayEntry?.remove();
        overlayEntry = SuccessOverlayEntry.build(checkAnimation);
        Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
        checkController.forward();
        Timer(const Duration(milliseconds: 1500), () {
          overlayEntry?.remove();
          Navigator.of(context).pop();
        });
      } else if (state.status.isFailed) {
        overlayEntry?.remove();
        overlayEntry = LoaderOverlayEntry.build();
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
