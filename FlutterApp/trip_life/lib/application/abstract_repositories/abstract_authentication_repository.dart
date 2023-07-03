abstract class AbstractAuthenticationRepository {
  Future<bool> saveToken(String token);
  Future<bool> saveUserId(String userId);
  String readToken();
  String readUserId();
  Future<bool> signIn(String email, String password);
  Future<bool> signUp(String username, String email, String password);
}
