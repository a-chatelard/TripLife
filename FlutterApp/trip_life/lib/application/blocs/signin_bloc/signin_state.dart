part of 'signin_bloc.dart';

enum SigninStatus { initial, loading, success, error }

extension SigninStatusX on SigninStatus {
  bool get isInitialized => this == SigninStatus.initial;
  bool get isLoading => this == SigninStatus.loading;
  bool get isSuccessful => this == SigninStatus.success;
  bool get isFailed => this == SigninStatus.error;
}

class SigninState extends Equatable {
  const SigninState._(
      {this.status = SigninStatus.initial, this.errorMessage = ""});

  const SigninState.initial() : this._();

  const SigninState.signinSucces() : this._(status: SigninStatus.success);

  const SigninState.signinLoading() : this._(status: SigninStatus.loading);

  const SigninState.signinError(String errorMessage)
      : this._(status: SigninStatus.error, errorMessage: errorMessage);

  final SigninStatus status;
  final String? errorMessage;

  @override
  List<Object> get props => [status, errorMessage ?? ""];
}
