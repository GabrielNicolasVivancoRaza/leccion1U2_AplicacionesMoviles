import '../models/post_model.dart';
import '../models/user_model.dart';

abstract class BaseDataSource {
  Future<List<PostModel>> fetchPosts({int start = 0, int limit = 10});
  Future<PostModel> fetchPostById(int id);
  Future<UserModel> fetchUserById(int userId);
  Future<List<PostModel>> searchPosts(String query);
}
