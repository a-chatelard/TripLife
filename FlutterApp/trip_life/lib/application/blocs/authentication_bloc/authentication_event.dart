part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {
  const AuthenticationEvent();
}

class DetermineAppUserAuthentication extends AuthenticationEvent {}
