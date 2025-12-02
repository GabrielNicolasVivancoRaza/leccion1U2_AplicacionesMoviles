import '../../domain/entities/post_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_post_by_id_usecase.dart';
import '../../domain/usecases/get_user_by_id_usecase.dart';
import 'base_viewmodel.dart';

class PostDetailViewModel extends BaseViewModel {
  final GetPostByIdUseCase getPostByIdUseCase;
  final GetUserByIdUseCase getUserByIdUseCase;

  PostEntity? post;
  UserEntity? user;
  String? errorMessage;

  PostDetailViewModel({
    required this.getPostByIdUseCase,
    required this.getUserByIdUseCase,
  });

  Future<void> cargarDetalles(int postId) async {
    setLoading(true);
    errorMessage = null;
    
    try {
      // Cargar el post
      post = await getPostByIdUseCase(postId);
      
      // Cargar el usuario autor del post
      if (post != null) {
        user = await getUserByIdUseCase(post!.userId);
      }
    } catch (e) {
      errorMessage = 'Error al cargar detalles: $e';
      post = null;
      user = null;
    }
    
    setLoading(false);
  }
}
