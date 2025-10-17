import 'package:social_media_clone/core/constants/api_constants.dart';
import 'package:social_media_clone/core/network/dio_client.dart';
import 'package:social_media_clone/data/models/user_model.dart';

class UserRemoteDataSource {
  final DioClient dioClient;

  UserRemoteDataSource(this.dioClient);

  Future<List<UserModel>> getAllUsers() async {
    final response = await dioClient.get(ApiConstants.getAllUsers);

    return (response.data as List)
        .map((json) => UserModel.fromJson(json))
        .toList();
  }

  Future<String> makeModerator(String userId) async {
    final response = await dioClient.post(
      ApiConstants.makeModerator,
      {},
    );
    if (response.statusCode == 200) {
      return 'User promoted to Moderator';
    } else {
      throw Exception('Failed to make moderator');
    }
  }

  Future<String> removeModerator(String userId) async {
    final response = await dioClient.post(
      ApiConstants.removeModerator,
      {},
    );
    if (response.statusCode == 200) {
      return 'Moderator removed';
    } else {
      throw Exception('Failed to remove moderator');
    }
  }
}
