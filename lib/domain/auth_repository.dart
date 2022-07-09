abstract class AuthRepository {
  Future<void> login(String user, String password);
  Future<bool> isAuthenticated();
  Future<void> signOut();
}