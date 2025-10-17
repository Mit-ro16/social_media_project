import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_clone/core/network/dio_client.dart';
import 'package:social_media_clone/data/datasources/remote/auth_remote_datasource.dart';
import 'package:social_media_clone/data/repository_impl/auth_repository_impl.dart';
import 'package:social_media_clone/domain/usecases/login_use_case.dart';
import 'package:social_media_clone/domain/usecases/signup_use_case.dart';


final dioClientProvider = Provider((ref) => DioClient());

final authRemoteDataSourceProvider = Provider(
  (ref) => AuthRemoteDataSource(ref.read(dioClientProvider)),
);

final authRepositoryProvider = Provider(
  (ref) => AuthRepositoryImpl(ref.read(authRemoteDataSourceProvider)),
);


final loginUseCaseProvider = Provider(
  (ref) => LoginUseCase(ref.read(authRepositoryProvider)),
);

final signupUseCaseProvider = Provider(
  (ref) => SignupUseCase(ref.read(authRepositoryProvider)),
);
