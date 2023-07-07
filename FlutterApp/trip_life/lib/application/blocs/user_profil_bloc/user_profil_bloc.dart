import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_friend_repository.dart';
import 'package:trip_life/entity/models/connected_user.dart';

part 'user_profil_event.dart';
part 'user_profil_state.dart';

class UserProfilBloc extends Bloc<UserProfilEvent, UserProfilState> {
  UserProfilBloc({required AbstractFriendRepository friendRepository})
      : _friendRepository = friendRepository,
        super(const UserProfilState.loading()) {
    on<UserProfilRequest>(_onUserProfilRequest);
  }

  final AbstractFriendRepository _friendRepository;

  Future<void> _onUserProfilRequest(
      UserProfilRequest event, Emitter<UserProfilState> emit) async {
    emit(const UserProfilState.loading());
    try {
      ConnectedUser user = await _friendRepository.getConnectedUser();
      return emit(UserProfilState.succes(user));
    } catch (error) {
      return emit(const UserProfilState.error(
          "Une erreur est survenue lors de la récupération des données."));
    }
  }
}
