import '../../domain/entities/post_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../datasources/base_datasource.dart';
import 'base_repository.dart';

class PostRepositoryImpl implements BaseRepository {
  final BaseDataSource dataSource;

  PostRepositoryImpl(this.dataSource);

  @override
  Future<List<PostEntity>> getPosts({int start = 0, int limit = 10}) {
    return dataSource.fetchPosts(start: start, limit: limit);
  }

  @override
  Future<PostEntity> getPostById(int id) {
    return dataSource.fetchPostById(id);
  }

  @override
  Future<UserEntity> getUserById(int userId) {
    return dataSource.fetchUserById(userId);
  }

  @override
  Future<List<PostEntity>> searchPosts(String query) {
    return dataSource.searchPosts(query);
  }
}
