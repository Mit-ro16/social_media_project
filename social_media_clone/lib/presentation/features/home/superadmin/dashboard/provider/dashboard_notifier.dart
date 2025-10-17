
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media_clone/core/network/failure.dart';
import 'package:social_media_clone/data/models/user_model.dart';
import 'package:social_media_clone/domain/repository/dashboard_repository.dart';

class DashboardNotifier extends StateNotifier<AsyncValue<List<UserModel>>> {
  final DashboardRepository repo;

  DashboardNotifier(this.repo) : super(const AsyncValue.loading()) {
    fetchAllUsers();
  }

  Future<void> fetchAllUsers() async {
    try {
      state = const AsyncValue.loading();
      final users = await repo.getAllUsers();
      state = AsyncValue.data(users);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<Either<Failure, String>> makeModerator(String userId) async {
    try {
      final res = await repo.makeModerator(userId);
      await fetchAllUsers();
      return Right(res);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> removeModerator(String userId) async {
    try {
      final res = await repo.removeModerator(userId);
      await fetchAllUsers();
      return Right(res);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
