import 'dart:convert';
import 'package:baseprogrammer/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';


class PostProvider {
Future<List<Post>> fetchPosts() async {
final uri = Uri.parse(ApiConstants.posts);
final response = await http.get(uri);


if (response.statusCode == 200) {
final List<dynamic> data = json.decode(response.body);
return data.map((json) => Post.fromJson(json)).toList();
} else {
throw Exception('Failed to load posts: ${response.statusCode}');
}
}
}