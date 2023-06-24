import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_authentication_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc(
      {required AbstractAuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const SignupState.initial()) {
    on<SignupRequested>(_onSignupRequested);
  }

  final AbstractAuthenticationRepository _authenticationRepository;

  Future<void> _onSignupRequested(
      SignupRequested event, Emitter<SignupState> emit) async {
    emit(const SignupState.loading());

    if (await _authenticationRepository.signUp(
        event.username, event.email, event.password)) {
      return emit(const SignupState.succes());
    } else {
      return emit(const SignupState.error("Erreur lors de l'inscription'"));
    }
  }
}
