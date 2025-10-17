import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_clone/data/datasources/remote/comments_remote_datasource.dart';
import 'package:social_media_clone/data/models/comment_model.dart';


final commentActionsProvider = Provider<CommentActions>((ref) {
  final dataSource = ref.read(commentRemoteDataSourceProvider);
  return CommentActions(dataSource);
});


final commentsProvider =
    FutureProvider.family<List<CommentModel>, int>((ref, postId) async {
  final dataSource = ref.read(commentRemoteDataSourceProvider);
  return await dataSource.getCommentsForPost(postId);
});

class CommentActions {
  final CommentRemoteDataSource dataSource;
  CommentActions(this.dataSource);

  
  Future<void> addComment(int postId, String content) async {
    await dataSource.createComment(postId, content);
  }

  
  Future<void> editComment(int commentId, String newContent) async {
    await dataSource.editComment(commentId, newContent);
  }

  
  Future<void> deleteComment(int commentId) async {
    await dataSource.deleteComment(commentId);
  }
}
