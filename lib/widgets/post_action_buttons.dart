import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../controllers/post_action_controller.dart';

class PostActionButtons extends StatelessWidget {
  final int postId;
  final String postTitle;
  final String postLink;

  const PostActionButtons({
    super.key,
    required this.postId,
    required this.postTitle,
    required this.postLink,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PostActionController());
    final colorScheme = Theme.of(context).colorScheme;

    return Obx(() {
      final isLiked = controller.isLiked(postId);
      final isSaved = controller.isSaved(postId);

      return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButton(
              icon: isLiked ? Icons.favorite : Icons.favorite_border,
              label: 'Like',
              color: isLiked ? Colors.redAccent : colorScheme.primary,
              onTap: () {
                controller.toggleLike(postId);

                Future.delayed(Duration(milliseconds: 100), () {
                  Get.showSnackbar(
                    GetSnackBar(
                      title: isLiked ? 'Post Unliked 💔' : 'Post Liked ❤️',
                      message: postTitle,
                      snackPosition: SnackPosition.BOTTOM,
                      duration: const Duration(seconds: 1),
                    ),
                  );
                });
              },

            ),
            _buildButton(
              icon: isSaved ? Icons.bookmark : Icons.bookmark_border,
              label: 'Save',
              color: isSaved ? Colors.amber : colorScheme.primary,
              onTap: () {
                controller.toggleSave(postId);

                Future.delayed(Duration(milliseconds: 100), () {
                  Get.showSnackbar(
                    GetSnackBar(
                      title: isSaved ? 'Removed from Saved ❌' : 'Post Saved 💾',
                      message: postTitle,
                      snackPosition: SnackPosition.BOTTOM,
                      duration: const Duration(seconds: 1),
                    ),
                  );
                });
              },

            ),
            _buildButton(
              icon: Icons.share,
              label: 'Share',
              color: colorScheme.primary,
              onTap: () {
                Share.share(
                    '${postTitle}\n\nRead more at: ${postLink}');
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _buildButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(height: 4),
          Text(label,
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w500, color: color)),
        ],
      ),
    );
  }
}
