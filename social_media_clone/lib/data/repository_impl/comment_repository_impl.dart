
import 'package:social_media_clone/data/datasources/remote/comments_remote_datasource.dart';
import 'package:social_media_clone/data/models/comment_model.dart';
import 'package:social_media_clone/domain/repository/comment_repository.dart';

class CommentRepositoryImpl implements CommentRepository {
  final CommentRemoteDataSource remoteDataSource;

  CommentRepositoryImpl(this.remoteDataSource);

  @override
  Future<CommentModel> createComment(int postId, String content) async {
    return await remoteDataSource.createComment(postId, content);
  }

  @override
  Future<List<CommentModel>> getCommentsForPost(int postId) async {
    return await remoteDataSource.getCommentsForPost(postId);
  }

  @override
  Future<CommentModel> editComment(int commentId, String newContent) async {
    return await remoteDataSource.editComment(commentId, newContent);
  }

  @override
  Future<void> deleteComment(int commentId) async {
    await remoteDataSource.deleteComment(commentId);
  }

  @override
  Future<List<CommentModel>> getAllComments() async {
    return await remoteDataSource.getAllComments();
  }

  @override
  Future<List<CommentModel>> getUserComments() async {
    return await remoteDataSource.getUserComments();
  }
}
