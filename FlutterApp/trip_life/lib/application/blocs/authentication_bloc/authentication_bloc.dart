import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_authentication_repository.dart';

import 'package:trip_life/entity/models/authentication.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
      {required AbstractAuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {
    on<DetermineAppUserAuthentication>(_onDetermineAppUserAuthentication);
    on<LogOutUserAuthentication>(_logOutAppUserAutnentication);
    add(DetermineAppUserAuthentication());
  }

  final AbstractAuthenticationRepository _authenticationRepository;

  Future<void> _onDetermineAppUserAuthentication(
      DetermineAppUserAuthentication event,
      Emitter<AuthenticationState> emit) async {
    String token = _authenticationRepository.readToken();

    if (token.isNotEmpty) {
      return emit(AuthenticationState.authenticated(Authentication(token)));
    }

    return emit(const AuthenticationState.unauthenticated());
  }

  Future<void> _logOutAppUserAutnentication(
      LogOutUserAuthentication event, Emitter<AuthenticationState> emit) async {
    _authenticationRepository.saveToken("");
    _authenticationRepository.saveUserId("");

    return emit(const AuthenticationState.unauthenticated());
  }
}
