import 'package:baseprogrammer/controllers/post_action_controller.dart';
import 'package:baseprogrammer/controllers/post_controller.dart';
import 'package:baseprogrammer/views/post_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LikedPostsScreen extends StatelessWidget {
  const LikedPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final postController = Get.find<PostController>();
    final actionController = Get.put(PostActionController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Liked Posts ❤️"),

        // actions: [
        //   // ✅ Clear All button
        //   Obx(() {
        //     if (actionController.likedPosts.isEmpty) {
        //       return const SizedBox();
        //     }
        //     return IconButton(
        //       icon: const Icon(Icons.delete_sweep),
        //       tooltip: "Clear All",
        //       onPressed: () {
        //         Get.dialog(
        //           AlertDialog(
        //             title: const Text("Clear All Likes?"),
        //             content: const Text(
        //                 "Do you want to remove all liked posts?"),
        //             actions: [
        //               TextButton(
        //                 child: const Text("Cancel"),
        //                 onPressed: () => Get.back(),
        //               ),
        //               TextButton(
        //                 child: const Text("Clear All",
        //                     style: TextStyle(color: Colors.red)),
        //                 onPressed: () {
        //                   actionController.clearAllLikes();
        //                   Get.back();
        //                 },
        //               ),
        //             ],
        //           ),
        //         );
        //       },
        //     );
        //   }),
        // ],
      ),

      body: Obx(() {
        final likedIds = actionController.likedPosts;

        final likedPosts = postController.posts
            .where((post) => likedIds.contains(post.id))
            .toList();

        if (likedPosts.isEmpty) {
          return const Center(
            child: Text("No liked posts yet ❤️"),
          );
        }

        return ListView.builder(
          itemCount: likedPosts.length,
          itemBuilder: (context, index) {
            final post = likedPosts[index];

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: ListTile(
                leading: post.imageUrl.isNotEmpty
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    post.imageUrl,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 70,
                      height: 70,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.broken_image, size: 24),
                    ),
                  ),
                )
                    : const Icon(Icons.image),

                title: Text(
                  post.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                subtitle: const Text("Tap to read"),

                // ✅ Remove single liked post
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    actionController.toggleLike(post.id);

                    // Get.snackbar(
                    //   "Removed",
                    //   "Post removed from liked",
                    //   snackPosition: SnackPosition.BOTTOM,
                    //   duration: const Duration(seconds: 1),
                    // );
                  },
                ),

                onTap: () => Get.to(() => PostDetailScreen(post: post)),
              ),
            );
          },
        );
      }),
    );
  }
}
