import 'package:social_media_clone/data/models/comment_model.dart';


abstract class CommentRepository {
  
  Future<CommentModel> createComment(int postId, String content);

  
  Future<List<CommentModel>> getCommentsForPost(int postId);

  
  Future<CommentModel> editComment(int commentId, String newContent);

  
  Future<void> deleteComment(int commentId);

 
  Future<List<CommentModel>> getAllComments();

  
  Future<List<CommentModel>> getUserComments();
}
