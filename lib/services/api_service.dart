import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUri;

  ApiService(this.baseUri);

  Future<http.Response> getPosts() async {
    final response = await http.get(
      Uri.parse('$baseUri/posts'),
      headers: {'Content-Type': 'application/json'},
    );
    return response;
  }
}


class ApiService {
  final String baseUri = Config.apiUri;
      body: jsonEncode({'postId': postId, 'scheduledTime': scheduledTime.toIso8601String()}),
    );
    return response;
  }
}


  Future<http.Response> sendPost(Map<String, dynamic> postData) async {
    final response = await http.post(
      Uri.parse('$baseUri/posts'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(postData),
    );
    return response;
  }

  Future<http.Response> schedulePost(String postId, DateTime scheduledTime) async {
    final response = await http.post(
      Uri.parse('$baseUri/schedule'),
      headers: {'Content-Type': 'application/json'},