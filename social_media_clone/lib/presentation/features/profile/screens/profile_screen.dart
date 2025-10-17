import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';

import 'package:social_media_clone/presentation/features/add_posts/provider/add_posts_provider.dart';
import 'package:social_media_clone/presentation/features/home/widgets/post_card.dart';
import 'package:social_media_clone/presentation/features/home/user/screen/users_home_screen.dart';
import 'package:social_media_clone/presentation/features/home/widgets/add_posts_bottom_sheet.dart';
import 'package:social_media_clone/presentation/features/home/provider/home_provider.dart';

@RoutePage()
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  Future<void> openCreateSheet(BuildContext context) async {
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
            ref.invalidate(userPostsProvider);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget buildTab(String status) {
    final postsAsync = ref.watch(userPostsProvider);

    return postsAsync.when(
      data: (posts) {
        final filtered = posts
            .where((p) => p.status.toLowerCase() == status.toLowerCase())
            .toList();

        if (filtered.isEmpty) {
          return Center(child: Text('No ${status.toUpperCase()} posts'));
        }

        return ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (ctx, i) {
            final p = filtered[i];
            return Card(
              margin: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PostCard(post: p),
                  if (status.toLowerCase() == 'pending')
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await ref
                                  .read(homeRepositoryProvider)
                                  .approvePost(p.postId);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Post approved')),
                              );
                              ref.invalidate(userPostsProvider);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: const Text('Approve'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () async {
                              await ref
                                  .read(homeRepositoryProvider)
                                  .rejectPost(p.postId);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Post rejected')),
                              );
                              ref.invalidate(userPostsProvider);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text('Reject'),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('Error: $e')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(text: 'Posts'),
            Tab(text: 'Pending'),
            Tab(text: 'Rejected'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          buildTab('approved'),
          buildTab('pending'),
          buildTab('rejected'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openCreateSheet(context),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (i) {
          if (i == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const UserHomeScreen()),
            );
          }
          if (i == 1) {
            openCreateSheet(context);
          }
          if (i == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
          }
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
