part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {
  const AuthenticationEvent();
}

class _DetermineAppUserAuthentication extends AuthenticationEvent {}
