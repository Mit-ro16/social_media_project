import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_clone/presentation/features/comment/provider/comment_provider.dart';

class CommentsBottomSheet extends ConsumerStatefulWidget {
  final int postId;
  const CommentsBottomSheet({super.key, required this.postId});

  @override
  ConsumerState<CommentsBottomSheet> createState() =>
      _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends ConsumerState<CommentsBottomSheet> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final commentsAsync = ref.watch(commentsProvider(widget.postId));

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 16,
        left: 16,
        right: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Comments',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          
          commentsAsync.when(
            data: (comments) {
              if (comments.isEmpty) return const Text('No comments yet');
              return ListView.builder(
                shrinkWrap: true,
                itemCount: comments.length,
                itemBuilder: (ctx, i) {
                  final c = comments[i];
                  return ListTile(
                    title: Text(c.username),
                    subtitle: Text(c.content),
                  );
                },
              );
            },
            loading: () => const Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
            error: (e, s) => Text('Error: $e'),
          ),
          const Divider(),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Write a comment...',
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Colors.blue),
                onPressed: () async {
                  final content = _controller.text.trim();
                  if (content.isEmpty) return;

                  try {
                    
                    await ref
                        .read(commentActionsProvider)
                        .addComment(widget.postId, content);

                    
                    _controller.clear();

                    
                    ref.invalidate(commentsProvider(widget.postId));
                  } catch (e) {
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to send comment: $e')),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
