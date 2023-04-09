import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_authentication_repository.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc(
      {required AbstractAuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const SigninState.initial()) {
    on<_SigninRequested>(_onSigninRequested);
  }

  final AbstractAuthenticationRepository _authenticationRepository;

  Future<void> _onSigninRequested(
      _SigninRequested event, Emitter<SigninState> emit) async {
    emit(const SigninState.signinLoading());

    if (await _authenticationRepository.signIn(event.email, event.password)) {
      return emit(const SigninState.signinSucces());
    } else {
      return emit(const SigninState.signinError("Erreur lors de la connexion"));
    }
  }
}
