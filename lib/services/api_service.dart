import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import '../models/post.dart';
import '../models/comment.dart';

class ApiService {
  static Future<List<Post>> fetchPosts() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List jsonData = json.decode(response.body);
        return jsonData.map((p) => Post.fromJson(p)).toList();
      } else {
        // fallback if server returns non-200
        print('⚠️ API failed with status ${response.statusCode}, loading local file.');
        return await _loadPostsFromAsset();
      }
    } catch (e) {
      // fallback on network error
      print('⚠️ Network error: $e, loading local file.');
      return await _loadPostsFromAsset();
    }
  }

  static Future<List<Post>> _loadPostsFromAsset() async {
    final jsonString = await rootBundle.loadString('assets/posts.json');
    List jsonData = json.decode(jsonString);
    return jsonData.map((p) => Post.fromJson(p)).toList();
  }

  static Future<List<Comment>> fetchComments(int postId) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/$postId/comments');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List jsonData = json.decode(response.body);
        return jsonData.map((c) => Comment.fromJson(c)).toList();
      } else {
        throw Exception('Failed to load comments. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
