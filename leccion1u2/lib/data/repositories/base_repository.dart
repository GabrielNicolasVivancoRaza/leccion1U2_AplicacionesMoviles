import '../../domain/entities/post_entity.dart';
import '../../domain/entities/user_entity.dart';

abstract class BaseRepository {
  Future<List<PostEntity>> getPosts({int start = 0, int limit = 10});
  Future<PostEntity> getPostById(int id);
  Future<UserEntity> getUserById(int userId);
  Future<List<PostEntity>> searchPosts(String query);
}
