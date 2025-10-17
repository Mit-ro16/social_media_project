import 'package:flutter/material.dart';
import 'package:social_media_clone/data/models/post_model.dart';

typedef VoidPostCallback = void Function();

class PostCard extends StatelessWidget {
  final PostModel post;
  final VoidPostCallback? onComments;
  final VoidPostCallback? onBlacklist;

  const PostCard({super.key, required this.post, this.onComments, this.onBlacklist});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
           
            if (onBlacklist != null)
              IconButton(
                icon: const Icon(Icons.block, semanticLabel: 'blacklist'),
                onPressed: onBlacklist,
              ),
          ]),
          if (post.title.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(post.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ],
          const SizedBox(height: 6),
          Text(post.content),
          const SizedBox(height: 8),
          TextButton.icon(onPressed: onComments, icon: const Icon(Icons.comment), label: const Text('Comments')),
        ]),
      ),
    );
  }
}
