import 'package:flutter/material.dart';

import '../models/post_model.dart';
import '../services/api_service.dart';


  ApiService(this.baseUri);
  final ApiService _apiService = ApiService();

  List<Post> get posts => _posts;

  Future<void> fetchPosts() async {
    final response = await _apiService.getPosts();
    if (response.statusCode == 200) {
      notifyListeners();
    }
  }

  Future<void> addPost(Post post) async {
    final response = await _apiService.sendPost(post.toJson());
    if (response.statusCode == 200) {
      _posts.add(post);
      notifyListeners();
    }
  }

  Future<void> schedulePost(String postId, DateTime scheduledTime) async {
    final response = await _apiService.schedulePost(postId, scheduledTime);
    if (response.statusCode == 200) {
      notifyListeners();
    }
  }
}


  Future<http.Response> getPosts() async {
    return await http.get(Uri.parse('$baseUri/posts'));
  }
}

class PostProvider with ChangeNotifier {
  List<Post> _posts = [];
class ApiService {
  final String baseUri;