import 'dart:convert';
import 'dart:developer';

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
  Future<bool> authenticate(String token) async {
    var response = await _httpClient.post(
        "/authentication",
        jsonEncode(<String, String>{
          'token': token,
        }));

    inspect(response);

    return response.statusCode == 200;
  }

  @override
  String readToken() {
    return _localStore.readStringValue('token') ?? "";
  }

  @override
  Future<bool> saveToken(String token) {
    return _localStore.saveStringValue('token', token);
  }

  @override
  Future<bool> signOut(String token) {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<bool> signIn(String email, String password) async {
    var response = await _httpClient.post("/login",
        jsonEncode(<String, String>{'email': email, 'password': password}));

    return response.statusCode == 200 &&
        await saveToken(jsonDecode(response.body)['token']);
  }
}