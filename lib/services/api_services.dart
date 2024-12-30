import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_clinikk/models/post_model.dart';



class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  static Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  static Future<List<Post>> fetchPostsByUserId(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl?userId=$userId'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts for user ID: $userId');
    }
  }
}

