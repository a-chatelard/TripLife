import 'dart:convert';

import 'package:trip_life/application/abstract_repositories/abstract_authentication_repository.dart';
import 'package:trip_life/infrastructure/abstracts/abstract_local_store.dart';
import 'package:trip_life/infrastructure/abstracts/asbtract_http_client.dart';

class AuthenticationRepository implements AbstractAuthenticationRepository {
  AuthenticationRepository(
      {required AbstractLocalStore localStore,
      required AbstractHttpClient httpClient})
      : _localStore = localStore,
        _httpClient = httpClient;

  final AbstractLocalStore _localStore;
  final AbstractHttpClient _httpClient;

  @override
  String readToken() {
    return _localStore.readStringValue('token') ?? "";
  }

  @override
  String readUserId() {
    return _localStore.readStringValue('userId') ?? "";
  }

  @override
  Future<bool> saveToken(String token) {
    return _localStore.saveStringValue('token', token);
  }

  @override
  Future<bool> saveUserId(String userId) {
    return _localStore.saveStringValue('userId', userId);
  }

  @override
  Future<bool> signIn(String email, String password) async {
    var response = await _httpClient.post("/Auth/LogIn",
        jsonEncode(<String, String>{'email': email, 'password': password}));

    return response.statusCode == 200 &&
        await saveToken(jsonDecode(response.body)['accessToken']);
  }

  @override
  Future<bool> signUp(String username, String email, String password) async {
    var response = await _httpClient.post(
        "/Auth/SignUp",
        jsonEncode(<String, String>{
          'username': username,
          'email': email,
          'password': password
        }));

    return response.statusCode == 200;
  }
}
