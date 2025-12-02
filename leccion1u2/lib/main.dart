import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/viewmodels/post_viewmodel.dart';
import 'domain/usecases/get_posts_usecase.dart';
import 'domain/usecases/search_posts_usecase.dart';
import 'data/repositories/post_repository_impl.dart';
import 'data/datasources/post_api_datasource.dart';

import 'presentation/routes/app_routes.dart';

void main() {
  // Inyección de dependencias
  final dataSource = PostApiDataSource();
  final repository = PostRepositoryImpl(dataSource);
  
  // Casos de uso
  final getPostsUseCase = GetPostsUseCase(repository);
  final searchPostsUseCase = SearchPostsUseCase(repository);

  runApp(MyApp(
    getPostsUseCase: getPostsUseCase,
    searchPostsUseCase: searchPostsUseCase,
  ));
}

class MyApp extends StatelessWidget {
  final GetPostsUseCase getPostsUseCase;
  final SearchPostsUseCase searchPostsUseCase;

  const MyApp({
    super.key,
    required this.getPostsUseCase,
    required this.searchPostsUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PostViewModel(
            getPostsUseCase: getPostsUseCase,
            searchPostsUseCase: searchPostsUseCase,
          )..cargarPosts(),
        ),
      ],
      child: MaterialApp(
        title: "JSONPlaceholder - Posts",
        initialRoute: "/",
        routes: AppRoutes.routes,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
      ),
    );
  }
}
