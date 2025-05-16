import 'package:instagram_clone/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:instagram_clone/features/profile/domain/entities/profile_entity.dart';
import 'package:instagram_clone/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ProfileEntity> getUserProfile(String username) async {
    return await remoteDataSource.getUserProfile(username);
  }

  @override
  Future<void> followUser(String username) async {
    await remoteDataSource.followUser(username);
  }

  @override
  Future<void> unfollowUser(String username) async {
    await remoteDataSource.unfollowUser(username);
  }
}