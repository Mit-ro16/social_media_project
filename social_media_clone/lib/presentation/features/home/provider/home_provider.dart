import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_clone/core/network/dio_client.dart';
import 'package:social_media_clone/data/models/post_model.dart';

import 'package:social_media_clone/data/repository_impl/post_repository.dart';

final dioClientProvider = Provider((ref) => DioClient());

final homeRepositoryProvider = Provider(
  (ref) => PostRepository(ref.read(dioClientProvider)),
);

final approvedPostsProvider = FutureProvider.autoDispose<List<PostModel>>((
  ref,
) async {
  final repo = ref.read(homeRepositoryProvider);
  return repo.fetchApprovedPosts();
});

final homeActionProvider = Provider((ref) {
  final repo = ref.read(homeRepositoryProvider);
  return HomeActions(repo);
});

class HomeActions {
  final PostRepository repo;
  HomeActions(this.repo);

  Future<void> blacklistPost(String postId) {
    return repo.blacklistPost(postId);
  }

  Future<List<Map<String, dynamic>>> getAllUsers() {
    return repo.getAllUsers();
  }

  Future<void> makeModerator(String userId) {
    return repo.makeModerator(userId);
  }

  Future<void> removeModerator(String userId) {
    return repo.removeModerator(userId);
  }
}
