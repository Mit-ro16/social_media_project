import 'package:social_media_clone/data/datasources/remote/auth_remote_datasource.dart';
import 'package:social_media_clone/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  AuthRepositoryImpl(this.remote);

  @override
  Future<Map<String, dynamic>> login(String email, String password) {
    return remote.login(email, password);
  }

  @override
  Future<Map<String,dynamic>> signUp(
    String email,
    String username,
    String password,
    String confirmPassword,
  ) {
    return remote.signUp(email, username, password, confirmPassword);
  }
}
