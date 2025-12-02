import '../entities/user_entity.dart';
import '../../data/repositories/base_repository.dart';

class GetUserByIdUseCase {
  final BaseRepository repository;

  GetUserByIdUseCase(this.repository);

  Future<UserEntity> call(int userId) {
    return repository.getUserById(userId);
  }
}
