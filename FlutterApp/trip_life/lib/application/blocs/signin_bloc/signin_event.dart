part of 'signin_bloc.dart';

class SigninEvent {}

class SigninRequested extends SigninEvent {
  final String email;
  final String password;

  SigninRequested(this.email, this.password);
}
