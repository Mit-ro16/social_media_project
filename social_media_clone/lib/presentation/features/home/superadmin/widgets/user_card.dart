import 'package:flutter/material.dart';
import 'package:social_media_clone/data/models/user_model.dart';

typedef UserActionCallback = Future<void> Function();

class UserCard extends StatelessWidget {
  final UserModel user;
  final UserActionCallback onMakeModerator;
  final UserActionCallback onRemoveModerator;

  const UserCard({
    super.key,
    required this.user,
    required this.onMakeModerator,
    required this.onRemoveModerator,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ListTile(
        title: Text(user.username),
       
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: user.isModerator ? null : onMakeModerator,
              child: const Text('Make Moderator'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: user.isModerator ? onRemoveModerator : null,
              child: const Text('Remove'),
            ),
          ],
        ),
      ),
    );
  }
}
