import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../services/api_service.dart';

class PostProvider with ChangeNotifier {
  final List<Post> _posts = [];
  final ApiService _apiService = ApiService();

  List<Post> get posts => _posts;

  Future<void> fetchPosts() async {
    final response = await _apiService.getPosts();
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      _posts.clear();
      _posts.addAll(data.map((json) => Post.fromJson(json)).toList());
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
      // Update the post's scheduledTime if necessary
      notifyListeners();
    }
  }
}
