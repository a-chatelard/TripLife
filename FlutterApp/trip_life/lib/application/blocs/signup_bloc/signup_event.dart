part of 'signup_bloc.dart';

class SignupEvent {}

class SignupRequested extends SignupEvent {
  final String username;
  final String email;
  final String password;

  SignupRequested(this.username, this.email, this.password);
}
