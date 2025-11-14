import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PostActionController extends GetxController {
  final _storage = GetStorage();

  // Observable lists for liked and saved posts
  final likedPosts = <int>[].obs;
  final savedPosts = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadStoredData();
  }

  // 🔹 Load saved data from local storage
  void _loadStoredData() {
    final liked = _storage.read<List>('likedPosts') ?? [];
    final saved = _storage.read<List>('savedPosts') ?? [];

    likedPosts.assignAll(liked.cast<int>());
    savedPosts.assignAll(saved.cast<int>());
  }

  // ❤️ Toggle Like
  void toggleLike(int postId) {
    if (likedPosts.contains(postId)) {
      likedPosts.remove(postId);
    } else {
      likedPosts.add(postId);
    }
    _storage.write('likedPosts', likedPosts);
  }

  // 💾 Toggle Save
  void toggleSave(int postId) {
    if (savedPosts.contains(postId)) {
      savedPosts.remove(postId);
    } else {
      savedPosts.add(postId);
    }
    _storage.write('savedPosts', savedPosts);
  }
  void clearAllLikes() {
    likedPosts.clear();
    _storage.write('likedPosts', []);
  }

  void clearAllSaved() {
    savedPosts.clear();
    _storage.write('savedPosts', []);
  }



  bool isLiked(int postId) => likedPosts.contains(postId);
  bool isSaved(int postId) => savedPosts.contains(postId);
}
