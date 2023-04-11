part of 'signup_bloc.dart';

enum SignupStatus { initial, loading, success, error }

extension SignupStatusX on SignupStatus {
  bool get isInitialized => this == SignupStatus.initial;
  bool get isLoading => this == SignupStatus.loading;
  bool get isSuccessful => this == SignupStatus.success;
  bool get isFailed => this == SignupStatus.error;
}

class SignupState extends Equatable {
  const SignupState._(
      {this.status = SignupStatus.initial, this.errorMessage = ""});

  const SignupState.initial() : this._();

  const SignupState.succes() : this._(status: SignupStatus.success);

  const SignupState.loading() : this._(status: SignupStatus.loading);

  const SignupState.error(String errorMessage)
      : this._(status: SignupStatus.error, errorMessage: errorMessage);

  final SignupStatus status;
  final String? errorMessage;

  @override
  List<Object> get props => [status, errorMessage ?? ""];
}
