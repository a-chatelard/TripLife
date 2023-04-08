import 'package:trip_life/application/abstract_repositories/abstract_authentication_repository.dart';
import 'package:trip_life/infrastructure/abstract/abstract_local_store.dart';

class AuthenticationRepository implements AbstractAuthenticationRepository {
  AuthenticationRepository({required AbstractLocalStore localStore})
      : _localStore = localStore;

  final AbstractLocalStore _localStore;

  @override
  Future<bool> authenticate(String token) {
    // TODO: implement authenticate
    throw UnimplementedError();
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
}
