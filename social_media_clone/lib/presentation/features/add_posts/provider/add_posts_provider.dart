import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_clone/data/datasources/remote/post_remote_data_source.dart';
import 'package:social_media_clone/data/models/post_model.dart';
import 'package:social_media_clone/presentation/features/home/provider/home_provider.dart';

final addPostActionsProvider = Provider<AddPostActions>((ref) {
  final dataSource = ref.read(postRemoteDataSourceProvider);
  return AddPostActions(dataSource);
});

final approvedPostsProvider = FutureProvider<List<PostModel>>((ref) async {
  final dataSource = ref.read(postRemoteDataSourceProvider);
  return await dataSource.getApprovedPosts();
});


final userPostsProvider = FutureProvider.autoDispose<List<PostModel>>((
  ref,
) async {
  final repo = ref.read(homeRepositoryProvider);
  return repo.fetchUserPosts();
});


final pendingPostsProvider = FutureProvider<List<PostModel>>((ref) async {
  final repo = ref.read(homeRepositoryProvider);
  return repo.getPendingPosts();
});


class AddPostActions {
  final PostRemoteDataSource _dataSource;
  AddPostActions(this._dataSource);

  Future<void> addPost(String title, String content) async {
    await _dataSource.uploadPost(title, content);
  }
}
