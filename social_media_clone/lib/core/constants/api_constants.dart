class ApiConstants {
  static const String baseUrl =
      'https://nonsudsing-worked-simona.ngrok-free.dev';

  static const String login = '/api/auth/login';
  static const String signup = '/api/auth/signup';

  static const String createPost = '/api/posts/create';
  static const String getAllLivePosts = '/api/posts/live';
  static const String deletePost = '/api/posts';
  static const String getUserPosts = '/api/posts/profile';
  static const String approveUsersPost = '/api/moderator/posts/{id}/approve';
  static const String rejectUsersPost = '/api/moderator/posts/{id}/disapprove';
  static const String getPendingPost = '/api/moderator/posts/pending';
  static const String getRejectedPost = '/api/moderator/posts/blocked';

  static const String createComment = '/api/comments/post/{postId}';

  static const String getCommentsForPost = '/api/comments/post';

  static const String editComment = '/api/comments';

  static const String deleteComment = '/api/comments';

  static const String getAllComments = '/api/comments/post/approved/{postId}';

  static const String getUserComments = '/api/comments/profile';

  static const String blacklistPost = '/api/moderator/posts/{id}/disapprove';

  static const String getAllUsers = '/api/users';
  static const String makeModerator = '/api/admin/moderators/{userId}';
  static const String removeModerator = '/api/admin/moderators/{userId}';
}
