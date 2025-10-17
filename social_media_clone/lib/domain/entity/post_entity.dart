class PostEntity {
  final int postId;
  final String title;
  final String content;
  final String status;
  final String dateTime;
  final int userId;
  final String username;

  const PostEntity({
    required this.postId,
    required this.title,
    required this.content,
    required this.status,
    required this.dateTime,
    required this.userId,
    required this.username,
  });
}
