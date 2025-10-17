import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_clone/core/network/failure.dart';
import 'package:social_media_clone/presentation/features/add_posts/provider/add_posts_provider.dart';
import 'package:social_media_clone/presentation/features/home/widgets/add_posts_bottom_sheet.dart';
import 'package:social_media_clone/presentation/features/home/widgets/comments_bottom_sheet.dart';
import 'package:social_media_clone/presentation/features/home/widgets/post_card.dart';
import 'package:social_media_clone/presentation/features/home/superadmin/dashboard/screen/dashboard_screen.dart';
import 'package:social_media_clone/presentation/features/profile/screens/profile_screen.dart';

@RoutePage()
class SuperAdminHomeScreen extends ConsumerStatefulWidget {
  const SuperAdminHomeScreen({super.key});

  @override
  ConsumerState<SuperAdminHomeScreen> createState() =>
      _SuperAdminHomeScreenState();
}

class _SuperAdminHomeScreenState extends ConsumerState<SuperAdminHomeScreen> {
  int _selectedIndex = 0;

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
  Widget build(BuildContext context) {
    final pages = [
      Consumer(
        builder: (context, ref, _) {
          final postsAsync = ref.watch(approvedPostsProvider);
          return postsAsync.when(
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
            error: (e, _) {
              final msg = e is Failure ? e.message : e.toString();
              return Center(child: Text('Error: $msg'));
            },
          );
        },
      ),

      Container(),

      const ProfileScreen(),

      const DashboardScreen(),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (i) {
          if (i == 1) {
            openCreateSheet(context, ref);
          } else {
            setState(() {
              _selectedIndex = i;
            });
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Create'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
        ],
      ),
    );
  }
}
