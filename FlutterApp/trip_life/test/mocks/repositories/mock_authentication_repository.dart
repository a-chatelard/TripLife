import 'package:flutter_test/flutter_test.dart';
import 'package:trip_life/infrastructure/repositories/authentication_repository.dart';

class MockAuthenticationRepository implements AuthenticationRepository {
  @override
  Future<bool> signIn(String email, String password) async {
    return true;
  }

  @override
  Future<bool> signUp(String username, String email, String password) async {
    return true;
  }

  @override
  String readToken() {
    return "";
  }

  @override
  Future<bool> saveToken(String token) async {
    return true;
  }

  @override
  String readUserId() {
    return "";
  }

  @override
  Future<bool> saveUserId(String userId) async {
    return true;
  }
}
