import 'package:social_media_clone/domain/entity/post_entity.dart';

class PostModel extends PostEntity {
  const PostModel({
    required super.postId,
    required super.title,
    required super.content,
    required super.status,
    required super.dateTime,
    required super.userId,
    required super.username,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      postId: json['postId'] ?? 0,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      status: json['status'] ?? '',
      dateTime: json['dateTime'] ?? '',
      userId: json['userId'] ?? 0,
      username: json['username'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'postId': postId,
        'title': title,
        'content': content,
        'status': status,
        'dateTime': dateTime,
        'userId': userId,
        'username': username,
      };
}
