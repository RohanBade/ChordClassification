abstract class AuthRepo {
  Future<bool> login(String email, String password);
  Future<bool> signUp(String userName, String email, String password);
}