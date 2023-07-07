part of 'activity_participation_bloc.dart';

enum ActivityParticipationStatus {
  initial,
  loadingState,
  loadingStateSuccess,
  loadingStateError,
  changeState,
  changeStateSuccess,
  changeStateError,
}

extension AddFriendStatusX on ActivityParticipationStatus {
  bool get isInitialized => this == ActivityParticipationStatus.initial;
  bool get isLoadingState => this == ActivityParticipationStatus.loadingState;
  bool get isLoadingStateSuccessful =>
      this == ActivityParticipationStatus.loadingStateSuccess;
  bool get isLoadingStateFailed =>
      this == ActivityParticipationStatus.loadingStateError;
  bool get isChangeState => this == ActivityParticipationStatus.changeState;
  bool get isChangeStateSuccessful =>
      this == ActivityParticipationStatus.changeStateSuccess;
  bool get isChangeStateFailed =>
      this == ActivityParticipationStatus.changeStateError;
}

class ActivityParticipationState extends Equatable {
  const ActivityParticipationState._(
      {this.status = ActivityParticipationStatus.initial,
      this.participate = false,
      this.errorMessage = ""});

  const ActivityParticipationState.initial() : this._();

  const ActivityParticipationState.loadingState()
      : this._(status: ActivityParticipationStatus.loadingState);

  const ActivityParticipationState.loadingStateSuccess(bool participate)
      : this._(
            status: ActivityParticipationStatus.loadingStateSuccess,
            participate: participate);

  const ActivityParticipationState.loadingStateError(String errorMessage)
      : this._(
            status: ActivityParticipationStatus.loadingStateError,
            errorMessage: errorMessage);

  const ActivityParticipationState.changeState()
      : this._(
          status: ActivityParticipationStatus.changeState,
        );

  const ActivityParticipationState.changeStateSuccess(bool participate)
      : this._(
            status: ActivityParticipationStatus.changeState,
            participate: participate);

  const ActivityParticipationState.changeStateError(String errorMessage)
      : this._(
            status: ActivityParticipationStatus.changeState,
            errorMessage: errorMessage);

  final bool participate;
  final ActivityParticipationStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, errorMessage ?? ""];
}
