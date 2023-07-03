import 'package:equatable/equatable.dart';

class ConnectedUser extends Equatable {
  const ConnectedUser(this.userId, this.username, this.email);

  final String userId;
  final String username;
  final String email;

  @override
  List<Object?> get props => [userId, username, email, email];
}
