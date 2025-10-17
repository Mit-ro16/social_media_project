import 'package:social_media_clone/domain/entity/comment_entity.dart';

class CommentModel extends CommentEntity {
  const CommentModel({
    required super.id,
    required super.content,
    required super.status,
    required super.postId,
    required super.username,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] ?? 0,
      content: json['content']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      postId: json['postId'] ?? 0,
      username: json['username']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'status': status,
        'postId': postId,
        'username': username,
      };
}
