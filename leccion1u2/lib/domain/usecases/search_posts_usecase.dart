import '../entities/post_entity.dart';
import '../../data/repositories/base_repository.dart';

class SearchPostsUseCase {
  final BaseRepository repository;

  SearchPostsUseCase(this.repository);

  Future<List<PostEntity>> call(String query) {
    return repository.searchPosts(query);
  }
}
