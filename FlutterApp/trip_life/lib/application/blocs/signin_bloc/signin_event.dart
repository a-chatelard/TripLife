part of 'signin_bloc.dart';

class SigninEvent {}

class _SigninRequested extends SigninEvent {
  final String email;
  final String password;

  _SigninRequested(this.email, this.password);
}
