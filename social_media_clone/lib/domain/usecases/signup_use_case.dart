import 'package:social_media_clone/domain/repository/auth_repository.dart';

class SignupUseCase {
  final AuthRepository repository;

  SignupUseCase(this.repository);

  Future<Map<String, dynamic>> call(
    String email,
    String username,
    String password,
    String confirmPassword,
  ) {
    return repository.signUp(email, username, password, confirmPassword);
  }
}
