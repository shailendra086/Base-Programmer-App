import 'dart:convert';
import 'package:baseprogrammer/models/post_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PostController extends GetxController {
  var posts = <Post>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;
  var page = 1.obs;
  var hasMore = true.obs;

  final String baseUrl = 'https://baseprogrammer.com/wp-json/wp/v2/posts?_embed';

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts({bool loadMore = false}) async {
    if (isLoading.value || (!hasMore.value && loadMore)) return;

    isLoading.value = true;
    error.value = '';

    try {
      if (!loadMore) {
        page.value = 1;
        posts.clear();
      }

      final response = await http.get(
        Uri.parse('$baseUrl&per_page=10&page=${page.value}'),
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        final List<Post> newPosts = data.map((p) => Post.fromJson(p)).toList();

        if (loadMore) {
          posts.addAll(newPosts);
        } else {
          posts.value = newPosts;
        }

        // If less than 10 posts are returned, no more data
        hasMore.value = newPosts.length == 10;
        if (hasMore.value) page.value++;
      } else {
        error.value = 'Failed to load posts (${response.statusCode})';
      }
    } catch (e) {
      error.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
