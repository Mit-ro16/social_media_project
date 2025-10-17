class UserEntity {
  final String id;
  final String username;
  final String email;
  final DateTime createdAt;
  final String role;

  const UserEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.createdAt,
    required this.role,
  });

  bool get isModerator => role == 'moderator';
}
