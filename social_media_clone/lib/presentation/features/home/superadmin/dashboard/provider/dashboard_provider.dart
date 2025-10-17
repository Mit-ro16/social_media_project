import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_clone/data/datasources/remote/user_remote_datasource.dart';
import 'package:social_media_clone/data/models/user_model.dart';
import 'package:social_media_clone/domain/repository/dashboard_repository.dart';
import 'package:social_media_clone/presentation/features/home/provider/home_provider.dart';
import 'dashboard_notifier.dart';

final userRemoteDataSourceProvider = Provider<UserRemoteDataSource>((ref) {
  final dioClient = ref.read(dioClientProvider);
  return UserRemoteDataSource(dioClient);
});

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  final remoteDataSource = ref.read(userRemoteDataSourceProvider);
  return DashboardRepository(remoteDataSource);
});


final dashboardProvider =
    StateNotifierProvider<DashboardNotifier, AsyncValue<List<UserModel>>>(
  (ref) {
    final repo = ref.read(dashboardRepositoryProvider);
    return DashboardNotifier(repo);
  },
);
