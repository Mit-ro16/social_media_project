import 'package:social_media_clone/core/constants/api_constants.dart';
import 'package:social_media_clone/core/network/dio_client.dart';
import 'package:social_media_clone/data/models/post_model.dart';

class PostRepository {
  final DioClient dio;

  PostRepository(this.dio);

  Future<List<PostModel>> fetchApprovedPosts() async {
    final res = await dio.get(ApiConstants.getAllLivePosts);
    final list = (res.data as List<dynamic>)
        .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return list;
  }

  Future<List<PostModel>> fetchUserPosts() async {
    final res = await dio.get(ApiConstants.getUserPosts);
    final data = res.data as List;
    return data
        .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> approvePost(int postId) async {
    try {
      final res = await dio.post(
        '/api/moderator/posts/$postId/approve', 
        {}, 
      );

      if (res.statusCode == 200) {
        print(' Post approved successfully');
      } else {
        print(' Failed to approve post: ${res.statusCode}');
      }
    } catch (e) {
      print(' Error approving post: $e');
      rethrow;
    }
  }

  Future<void> rejectPost(int postId) async {
    try {
      final res = await dio.post(
        '/api/moderator/posts/$postId/reject',
        {}, 
      );

      if (res.statusCode == 200) {
        print('Post rejected successfully');
      } else {
        print(' Failed to reject post: ${res.statusCode}');
      }
    } catch (e) {
      print(' Error rejecting post: $e');
      rethrow;
    }
  }

  Future<List<PostModel>> getPendingPosts() async {
  try {
    final res = await dio.get(ApiConstants.getPendingPost); 
    final data = res.data as List;

    return data.map((e) => PostModel.fromJson(e as Map<String, dynamic>)).toList();
  } catch (e) {
    print(' Error fetching pending posts: $e');
    rethrow;
  }
}
Future<List<PostModel>> getRejectedPosts() async {
  try {
    final res = await dio.get(ApiConstants.getRejectedPost); 
    final data = res.data as List;

    return data.map((e) => PostModel.fromJson(e as Map<String, dynamic>)).toList();
  } catch (e) {
    print('Error fetching rejected posts: $e');
    rethrow;
  }
}


  Future<PostModel> addPost({
    required String title,
    required String content,
    required String authorId,
    required String authorName,
  }) async {
    final res = await dio.post(ApiConstants.createPost, {
      'title': title,
      'content': content,
      'authorId': authorId,
      'authorName': authorName,
    });
    return PostModel.fromJson(res.data);
  }

  Future<void> blacklistPost(String postId) async {
    await dio.post('${ApiConstants.blacklistPost}/$postId', {});
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final res = await dio.get(ApiConstants.getAllUsers);
    return List<Map<String, dynamic>>.from(res.data as List);
  }

  Future<void> makeModerator(String userId) async {
    await dio.post('${ApiConstants.makeModerator}/$userId', {});
  }

  Future<void> removeModerator(String userId) async {
    await dio.post('${ApiConstants.removeModerator}/$userId', {});
  }
}
