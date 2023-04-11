abstract class AbstractAuthenticationRepository {
  Future<bool> authenticate(String token);
  Future<bool> saveToken(String token);
  String readToken();
  Future<bool> signOut(String token);
  Future<bool> signIn(String email, String password);
}
