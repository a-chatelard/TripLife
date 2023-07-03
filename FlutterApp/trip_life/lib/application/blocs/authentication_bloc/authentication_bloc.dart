import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_authentication_repository.dart';
import 'package:trip_life/application/abstract_repositories/abstract_friend_repository.dart';

import 'package:trip_life/entity/models/authentication.dart';
import 'package:trip_life/entity/models/connected_user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
      {required AbstractAuthenticationRepository authenticationRepository,
      required AbstractFriendRepository friendRepository})
      : _authenticationRepository = authenticationRepository,
        _friendRepository = friendRepository,
        super(const AuthenticationState.unknown()) {
    on<DetermineAppUserAuthentication>(_onDetermineAppUserAuthentication);
    on<LogOutUserAuthentication>(_logOutAppUserAutnentication);
    add(DetermineAppUserAuthentication());
  }

  final AbstractFriendRepository _friendRepository;
  final AbstractAuthenticationRepository _authenticationRepository;

  Future<void> _onDetermineAppUserAuthentication(
      DetermineAppUserAuthentication event,
      Emitter<AuthenticationState> emit) async {
    String token = _authenticationRepository.readToken();

    if (token.isNotEmpty) {
      ConnectedUser user = await _friendRepository.getConnectedUser();

      _authenticationRepository.saveUserId(user.userId);
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
