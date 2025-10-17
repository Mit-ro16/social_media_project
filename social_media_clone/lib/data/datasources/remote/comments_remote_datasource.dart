import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_clone/core/network/dio_client.dart';
import 'package:social_media_clone/data/models/comment_model.dart';
import 'package:social_media_clone/presentation/features/home/provider/home_provider.dart';

final commentRemoteDataSourceProvider = Provider<CommentRemoteDataSource>((
  ref,
) {
  final dioClient = ref.read(dioClientProvider);
  return CommentRemoteDataSource(dioClient);
});

class CommentRemoteDataSource {
  final DioClient dioClient;
  CommentRemoteDataSource(this.dioClient);

  
  Future<CommentModel> createComment(int postId, String content) async {
    final response = await dioClient.post('/api/comments/post/$postId', {
      'content': content,
    });
    return CommentModel.fromJson(response.data);
  }


  Future<List<CommentModel>> getCommentsForPost(int postId) async {
    final response = await dioClient.get('/api/comments/post/$postId');
    final data = response.data as List;
    return data.map((e) => CommentModel.fromJson(e)).toList();
  }


  Future<CommentModel> editComment(int commentId, String newContent) async {
    final response = await dioClient.put('/api/comments/update/{id}', {
      'content': newContent,
    });
    return CommentModel.fromJson(response.data);
  }

 
  Future<void> deleteComment(int commentId) async {
    await dioClient.delete('/api/comments/delete/{id}');
  }

  Future<List<CommentModel>> getAllComments() async {
    final response = await dioClient.get('/api/comments/post/approved/{postId}');
    final data = response.data as List;
    return data.map((e) => CommentModel.fromJson(e)).toList();
  }

 
  Future<List<CommentModel>> getUserComments() async {
    final response = await dioClient.get('/api/comments/profile');
    final data = response.data as List;
    return data.map((e) => CommentModel.fromJson(e)).toList();
  }
}
