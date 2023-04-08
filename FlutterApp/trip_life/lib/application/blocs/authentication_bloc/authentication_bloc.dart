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
    print("AuthenticationBloc constructor");
    on<_DetermineAppUserAuthentication>(_onDetermineAppUserAuthentication);
    add(_DetermineAppUserAuthentication());
  }

  final AbstractAuthenticationRepository _authenticationRepository;

  Future<void> _onDetermineAppUserAuthentication(
      _DetermineAppUserAuthentication event,
      Emitter<AuthenticationState> emit) async {
    String token = _authenticationRepository.readToken();

    if (token.isNotEmpty) {
      return emit(AuthenticationState.authenticated(Authentication(token)));
    } else {
      return emit(const AuthenticationState.unauthenticated());
    }
  }
}
