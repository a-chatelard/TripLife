part of 'authentication_bloc.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

extension AuthenticationStatusX on AuthenticationStatus {
  bool get isUnknown => this == AuthenticationStatus.unknown;
  bool get isAuthenticated => this == AuthenticationStatus.authenticated;
  bool get isUnauthenticated => this == AuthenticationStatus.unauthenticated;
}

class AuthenticationState extends Equatable {
  const AuthenticationState._(
      {this.authentication = Authentication.empty,
      this.status = AuthenticationStatus.unknown});

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(Authentication auth)
      : this._(
            authentication: auth, status: AuthenticationStatus.authenticated);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final Authentication authentication;
  final AuthenticationStatus status;

  @override
  List<Object> get props => [authentication, status];
}
