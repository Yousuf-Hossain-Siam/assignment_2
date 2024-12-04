import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'api_service.dart';
import 'post.dart';

class PostProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Post> _posts = [];
  bool _isLoading = false;
  bool _isOffline = false;

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;
  bool get isOffline => _isOffline;

  Future<void> fetchBooks(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      _posts = await _apiService.fetchBooks(query);
      _isOffline = false;
      await _cachePosts(_posts);
    } catch (e) {
      _isOffline = true;
      await _loadCachedPosts();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _cachePosts(List<Post> posts) async {
    final box = await Hive.openBox<Post>('posts');
    for (var post in posts) {
      box.put(post.title, post);
    }
  }

  Future<void> _loadCachedPosts() async {
    final box = await Hive.openBox<Post>('posts');
    _posts = box.values.toList();
    notifyListeners();
  }
}
