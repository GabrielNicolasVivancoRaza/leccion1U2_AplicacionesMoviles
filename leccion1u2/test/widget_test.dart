import 'package:flutter_test/flutter_test.dart';

import 'package:leccion1u2/main.dart';
import 'package:leccion1u2/data/datasources/post_api_datasource.dart';
import 'package:leccion1u2/data/repositories/post_repository_impl.dart';
import 'package:leccion1u2/domain/usecases/get_posts_usecase.dart';
import 'package:leccion1u2/domain/usecases/search_posts_usecase.dart';

void main() {
  testWidgets('App loads correctly', (WidgetTester tester) async {
    // Crear dependencias
    final dataSource = PostApiDataSource();
    final repository = PostRepositoryImpl(dataSource);
    final getPostsUseCase = GetPostsUseCase(repository);
    final searchPostsUseCase = SearchPostsUseCase(repository);

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(
      getPostsUseCase: getPostsUseCase,
      searchPostsUseCase: searchPostsUseCase,
    ));

    // Verify that the app title is present
    expect(find.text('Posts - JSONPlaceholder'), findsOneWidget);
  });
}
