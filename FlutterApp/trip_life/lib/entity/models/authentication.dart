import 'package:equatable/equatable.dart';

class Authentication extends Equatable {
  const Authentication(this.token);

  final String token;

  @override
  List<Object> get props => [token];

  static const empty = Authentication("");
}
