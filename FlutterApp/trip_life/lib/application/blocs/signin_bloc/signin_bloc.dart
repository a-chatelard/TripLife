import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_authentication_repository.dart';
import 'package:trip_life/application/abstract_repositories/abstract_friend_repository.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc(
      {required AbstractAuthenticationRepository authenticationRepository,
      required AbstractFriendRepository friendRepository})
      : _authenticationRepository = authenticationRepository,
        _friendRepository = friendRepository,
        super(const SigninState.initial()) {
    on<SigninRequested>(_onSigninRequested);
  }

  final AbstractAuthenticationRepository _authenticationRepository;
  final AbstractFriendRepository _friendRepository;

  Future<void> _onSigninRequested(
      SigninRequested event, Emitter<SigninState> emit) async {
    emit(const SigninState.loading());

    if (await _authenticationRepository.signIn(event.email, event.password)) {
      //await _friendRepository.getAddFriendResultList()

      return emit(const SigninState.succes());
    } else {
      return emit(const SigninState.error("Erreur lors de la connexion"));
    }
  }
}
