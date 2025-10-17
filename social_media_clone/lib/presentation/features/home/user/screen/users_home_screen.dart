import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_clone/presentation/features/add_posts/provider/add_posts_provider.dart';
import 'package:social_media_clone/presentation/features/home/widgets/add_posts_bottom_sheet.dart';
import 'package:social_media_clone/presentation/features/home/widgets/comments_bottom_sheet.dart';
import 'package:social_media_clone/presentation/features/home/widgets/post_card.dart';

@RoutePage()
class UserHomeScreen extends ConsumerWidget {
  const UserHomeScreen({super.key});

  Future<void> openCreateSheet(BuildContext context, WidgetRef ref) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: AddPostSheet(
          onSubmit: (title, content) async {
            await ref.read(addPostActionsProvider).addPost(title, content);
            ref.invalidate(approvedPostsProvider);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(approvedPostsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: postsAsync.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const Center(child: Text('No posts yet'));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(approvedPostsProvider),
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (ctx, i) {
                final p = posts[i];
                return PostCard(
                  post: p,
                  onComments: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (_) => CommentsBottomSheet(postId: p.postId),
                    );
                  },
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (i) {
          if (i == 1) openCreateSheet(context, ref);
          if (i == 2) Navigator.pushNamed(context, '/profile');
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Create Post',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
