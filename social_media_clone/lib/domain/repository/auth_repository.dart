
abstract class AuthRepository {
  Future<Map<String, dynamic>> login(String email, String password);

  Future<Map<String, dynamic>> signUp(
    String email,
    String username,
    String password,
    String confirmPassword,
  );
}
