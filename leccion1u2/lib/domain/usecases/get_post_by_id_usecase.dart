import '../entities/post_entity.dart';
import '../../data/repositories/base_repository.dart';

class GetPostByIdUseCase {
  final BaseRepository repository;

  GetPostByIdUseCase(this.repository);

  Future<PostEntity> call(int id) {
    return repository.getPostById(id);
  }
}
