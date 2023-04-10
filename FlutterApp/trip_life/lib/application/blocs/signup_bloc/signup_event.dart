part of 'signup_bloc.dart';

class SignupEvent {}

class SignupRequested extends SignupEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  SignupRequested(this.email, this.password, this.firstName, this.lastName);
}
