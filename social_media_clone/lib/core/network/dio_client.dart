import 'package:dio/dio.dart';
import 'package:social_media_clone/core/constants/api_constants.dart';
import 'package:social_media_clone/core/network/failure.dart';
import 'package:social_media_clone/core/shared_prefrences/shared_prefs.dart';

class DioClient {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<String?> getToken() async => await SharedPrefs.getToken();

 
  Failure handleDioError(DioException e) {
    String message = 'Network error';

    if (e.response?.data != null) {
      final data = e.response!.data;

      if (data is Map<String, dynamic> && data.containsKey('message')) {
        message = data['message'].toString();
      } else if (data is String) {
        message = data;
      } else {
        message = e.message ?? message;
      }
    } else if (e.message != null) {
      message = e.message!;
    }
    return Failure(message: message);
  }

  
  Future<Response> get(String endpoint) async {
    final token = await getToken();

    try {
      return await dio.get(
        endpoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

 
  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    final token = await getToken();

    try {
      return await dio.post(
        endpoint,
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  Future<Response> put(String endpoint, Map<String, dynamic> data) async {
    final token = await getToken();

    try {
      return await dio.put(
        endpoint,
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

 
  Future<Response> delete(String endpoint) async {
    final token = await getToken();

    try {
      return await dio.delete(
        endpoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }
}
