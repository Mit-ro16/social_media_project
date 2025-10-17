class CommentEntity {
  final int id;
  final String content;
  final String status;
  final int postId;
  final String username;

  const CommentEntity({
    required this.id,
    required this.content,
    required this.status,
    required this.postId,
    required this.username,
  });
}
