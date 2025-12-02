import '../entities/post_entity.dart';
import '../../data/repositories/base_repository.dart';

class GetPostsUseCase {
  final BaseRepository repository;

  GetPostsUseCase(this.repository);

  Future<List<PostEntity>> call({int start = 0, int limit = 10}) {
    return repository.getPosts(start: start, limit: limit);
  }
}
