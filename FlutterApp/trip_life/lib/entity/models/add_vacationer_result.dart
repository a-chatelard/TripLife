import 'package:equatable/equatable.dart';

class AddVacationerResult extends Equatable {
  const AddVacationerResult(
      this.id, this.username, this.hasReceivedVacationInvitation);

  final String id;
  final String username;
  final bool hasReceivedVacationInvitation;

  @override
  List<Object?> get props => [id, username, hasReceivedVacationInvitation];
}
