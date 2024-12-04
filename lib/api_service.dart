import 'dart:convert';
import 'package:http/http.dart' as http;
import 'post.dart';

class ApiService {
  static const String baseUrl = "https://openlibrary.org/search.json?q=";

  Future<List<Post>> fetchBooks(String query) async {
    final response = await http.get(Uri.parse('$baseUrl$query'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> docs = data['docs'];

      return docs.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }
}
