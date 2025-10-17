import 'package:social_media_clone/data/datasources/remote/user_remote_datasource.dart';
import 'package:social_media_clone/data/models/user_model.dart';

class DashboardRepository {
  final UserRemoteDataSource remoteDataSource;

  DashboardRepository(this.remoteDataSource);

  Future<List<UserModel>> getAllUsers() async {
    return await remoteDataSource.getAllUsers();
  }

  Future<String> makeModerator(String userId) async {
    return await remoteDataSource.makeModerator(userId);
  }

  Future<String> removeModerator(String userId) async {
    return await remoteDataSource.removeModerator(userId);
  }
}
