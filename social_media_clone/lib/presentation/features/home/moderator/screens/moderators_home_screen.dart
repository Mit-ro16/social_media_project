import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'package:social_media_clone/data/models/post_model.dart';

import 'package:social_media_clone/presentation/features/add_posts/provider/add_posts_provider.dart';
import 'package:social_media_clone/presentation/features/home/widgets/post_card.dart';
import 'package:social_media_clone/presentation/features/home/provider/home_provider.dart'
    hide approvedPostsProvider;
import 'package:social_media_clone/presentation/features/home/widgets/add_posts_bottom_sheet.dart';
import 'package:social_media_clone/presentation/features/profile/screens/profile_screen.dart';

@RoutePage()
class ModeratorHomeScreen extends ConsumerStatefulWidget {
  const ModeratorHomeScreen({super.key});

  @override
  ConsumerState<ModeratorHomeScreen> createState() =>
      _ModeratorHomeScreenState();
}

class _ModeratorHomeScreenState extends ConsumerState<ModeratorHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int currentIndex = 0;

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
            ref.invalidate(approvedPostsProvider);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget buildTab(AsyncValue<List<PostModel>> postsAsync, String status) {
    return postsAsync.when(
      data: (posts) {
        List<PostModel> filtered;
        if (status == 'ALL') {
          filtered = posts;
        } else {
          filtered = posts
              .where((p) => p.status.toLowerCase() == status.toLowerCase())
              .toList();
        }

        if (filtered.isEmpty) {
          return Center(child: Text('No $status posts'));
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
                  if (p.status.toLowerCase() == 'pending')
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await ref
                                .read(homeRepositoryProvider)
                                .approvePost(p.postId);
                            ref.invalidate(pendingPostsProvider);
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
                            ref.invalidate(pendingPostsProvider);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text('Reject'),
                        ),
                        const SizedBox(width: 8),
                      ],
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
    final approvedPosts = ref.watch(approvedPostsProvider);
    final pendingPosts = ref.watch(pendingPostsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Moderator Home'),
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Pending'),
            Tab(text: 'Approved'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          buildTab(pendingPosts, 'PENDING'),
          buildTab(approvedPosts, 'APPROVED'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openCreateSheet(context),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) {
          setState(() => currentIndex = i);
          if (i == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ModeratorHomeScreen()),
            );
          } else if (i == 1) {
            openCreateSheet(context);
          } else if (i == 2) {
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
