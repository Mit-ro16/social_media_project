import '../../../core/network/dio_client.dart';
import '../../../core/constants/api_constants.dart';

class AuthRemoteDataSource {
  final DioClient dioClient;
  AuthRemoteDataSource(this.dioClient);

  Future<Map<String, dynamic>> login(String email, String password) async {
    final res = await dioClient.post(ApiConstants.login, {
      'email': email,
      'password': password,
    });
    return res.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> signUp(
  String email,
  String username,
  String password,
  String confirmPassword,
) async {
  final res = await dioClient.post(
    ApiConstants.signup,
    {
      'email': email,
      'username': username,
      'password': password,
      'confirmPassword': confirmPassword,
    },
  );

  return res.data as Map<String, dynamic>;
}

}
