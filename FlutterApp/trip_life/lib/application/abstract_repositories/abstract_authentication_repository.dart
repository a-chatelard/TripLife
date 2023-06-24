abstract class AbstractAuthenticationRepository {
  Future<bool> saveToken(String token);
  String readToken();
  Future<bool> signIn(String email, String password);
  Future<bool> signUp(String username, String email, String password);
}
