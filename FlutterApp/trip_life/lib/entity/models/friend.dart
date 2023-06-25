import 'package:equatable/equatable.dart';

class Friend extends Equatable {
  const Friend(this.id, this.username);

  final String id;
  final String username;

  @override
  List<Object?> get props => [id, username];

  static fromJson(Map<String, dynamic> json) {
    return Friend(json['id'], json['username']);
  }
}
