import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_clone/core/constants/api_constants.dart';
import 'package:social_media_clone/core/network/dio_client.dart';
import 'package:social_media_clone/data/models/post_model.dart';
import 'package:social_media_clone/presentation/features/home/provider/home_provider.dart';

final postRemoteDataSourceProvider = Provider<PostRemoteDataSource>((ref) {
  final dioClient = ref.read(dioClientProvider);
  return PostRemoteDataSource(dioClient);
});

class PostRemoteDataSource {
  final DioClient dioClient;
  PostRemoteDataSource(this.dioClient);

  Future<void> createPost(String title, String content) async {
    try {
      final response = await dioClient.post(ApiConstants.createPost, {
        'title': title,
        'content': content,
      });

      if (response.statusCode != 200) {
        throw Exception('Failed to upload post');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PostModel>> getApprovedPosts() async {
    try {
      final response = await dioClient.get(ApiConstants.getAllLivePosts);
      final data = response.data as List;

      return data.map((json) => PostModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to fetch posts');
    }
  }

  Future<List<PostModel>> getUserPosts() async {
    final response = await dioClient.get(ApiConstants.getUserPosts);
    final data = response.data as List;
    return data.map((e) => PostModel.fromJson(e)).toList();
  }
}
