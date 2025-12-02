import 'dart:convert';
import 'package:http/http.dart' as http;
import 'base_datasource.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';

class PostApiDataSource implements BaseDataSource {
  final String baseUrl = "https://jsonplaceholder.typicode.com";

  @override
  Future<List<PostModel>> fetchPosts({int start = 0, int limit = 10}) async {
    try {
      final url = Uri.parse('$baseUrl/posts?_start=$start&_limit=$limit');
      final resp = await http.get(url);

      if (resp.statusCode != 200) {
        throw Exception("Error HTTP ${resp.statusCode}: ${resp.body}");
      }

      final dynamic decodedData = json.decode(resp.body);
      
      if (decodedData is! List) {
        throw Exception("La respuesta no es una lista válida");
      }
      
      final List data = decodedData;
      return data.map((item) => PostModel.fromJson(item)).toList();
    } catch (e) {
      throw Exception("Error de conexión: $e");
    }
  }

  @override
  Future<PostModel> fetchPostById(int id) async {
    try {
      final url = Uri.parse('$baseUrl/posts/$id');
      final resp = await http.get(url);

      if (resp.statusCode != 200) {
        throw Exception("Error HTTP ${resp.statusCode}: ${resp.body}");
      }

      return PostModel.fromJson(json.decode(resp.body));
    } catch (e) {
      throw Exception("Error al obtener post: $e");
    }
  }

  @override
  Future<UserModel> fetchUserById(int userId) async {
    try {
      final url = Uri.parse('$baseUrl/users/$userId');
      final resp = await http.get(url);

      if (resp.statusCode != 200) {
        throw Exception("Error HTTP ${resp.statusCode}: ${resp.body}");
      }

      return UserModel.fromJson(json.decode(resp.body));
    } catch (e) {
      throw Exception("Error al obtener usuario: $e");
    }
  }

  @override
  Future<List<PostModel>> searchPosts(String query) async {
    try {
      // Obtener todos los posts y filtrar localmente
      final url = Uri.parse('$baseUrl/posts');
      final resp = await http.get(url);

      if (resp.statusCode != 200) {
        throw Exception("Error HTTP ${resp.statusCode}: ${resp.body}");
      }

      final List data = json.decode(resp.body);
      final allPosts = data.map((item) => PostModel.fromJson(item)).toList();
      
      // Filtrar por título o cuerpo
      final filteredPosts = allPosts.where((post) {
        return post.title.toLowerCase().contains(query.toLowerCase()) ||
               post.body.toLowerCase().contains(query.toLowerCase());
      }).toList();

      return filteredPosts;
    } catch (e) {
      throw Exception("Error al buscar posts: $e");
    }
  }
}
