import '../../domain/entities/post_entity.dart';
import '../../domain/usecases/get_posts_usecase.dart';
import '../../domain/usecases/search_posts_usecase.dart';
import 'base_viewmodel.dart';

class PostViewModel extends BaseViewModel {
  final GetPostsUseCase getPostsUseCase;
  final SearchPostsUseCase searchPostsUseCase;

  List<PostEntity> posts = [];
  String? errorMessage;
  
  // Paginación
  int _currentPage = 0;
  final int _postsPerPage = 10;
  bool hasMorePosts = true;
  
  // Filtrado
  String _searchQuery = '';
  bool _isSearching = false;

  PostViewModel({
    required this.getPostsUseCase,
    required this.searchPostsUseCase,
  });

  // Cargar posts iniciales
  Future<void> cargarPosts({bool reset = false}) async {
    if (reset) {
      _currentPage = 0;
      posts = [];
      hasMorePosts = true;
    }

    if (!hasMorePosts || loading) return;

    setLoading(true);
    errorMessage = null;
    
    try {
      final newPosts = await getPostsUseCase(
        start: _currentPage * _postsPerPage,
        limit: _postsPerPage,
      );
      
      if (newPosts.isEmpty) {
        hasMorePosts = false;
      } else {
        posts.addAll(newPosts);
        _currentPage++;
      }
    } catch (e) {
      errorMessage = 'Error al cargar posts: $e';
    }
    
    setLoading(false);
  }

  // Cargar más posts (para scroll infinito)
  Future<void> cargarMasPosts() async {
    if (_isSearching) return;
    await cargarPosts();
  }

  // Buscar posts
  Future<void> buscarPosts(String query) async {
    _searchQuery = query.trim();
    
    if (_searchQuery.isEmpty) {
      _isSearching = false;
      posts = [];
      _currentPage = 0;
      hasMorePosts = true;
      await cargarPosts();
      return;
    }

    _isSearching = true;
    setLoading(true);
    errorMessage = null;
    
    try {
      posts = await searchPostsUseCase(_searchQuery);
      hasMorePosts = false;
    } catch (e) {
      errorMessage = 'Error al buscar posts: $e';
      posts = [];
    }
    
    setLoading(false);
  }

  // Limpiar búsqueda
  Future<void> limpiarBusqueda() async {
    _searchQuery = '';
    _isSearching = false;
    posts = [];
    _currentPage = 0;
    hasMorePosts = true;
    await cargarPosts();
  }

  bool get isSearching => _isSearching;
  String get searchQuery => _searchQuery;
}
