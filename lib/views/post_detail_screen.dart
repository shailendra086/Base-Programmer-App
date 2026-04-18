import 'package:baseprogrammer/services/ads/banner_ads.dart';
import 'package:baseprogrammer/widgets/post_action_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../models/post_model.dart';

class PostDetailScreen extends StatelessWidget {
  final Post post;
  const PostDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white.withOpacity(0.9) : Colors.black87;
    final bgColor = isDark ? Colors.grey[900] : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(title: Text(post.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (post.imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  post.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                  ),
                ),
              ),
            const SizedBox(height: 12),

            // 🏷️ Tags Section
            if (post.tags.isNotEmpty) ...[
              const Text(
                'Tags:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 6,
                runSpacing: -8,
                children: post.tags.map((tag) {
                  return Chip(
                    label: Text(
                      tag,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: isDark
                        ? Colors.deepPurple.shade400
                        : Colors.blueAccent.shade400,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: isDark
                            ? Colors.deepPurple.shade700
                            : Colors.blueAccent.shade700,
                        width: 0.6,
                      ),
                    ),
                    elevation: 2,
                    shadowColor: Colors.black26,
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
            ],

            // 📰 HTML Content
            Html(
              data: post.content,
              style: {
                "body": Style(
                  color: textColor,
                  fontSize: FontSize(16.0),
                  lineHeight: LineHeight(1.6),
                ),
                "p": Style(color: textColor),
                "a": Style(
                  color: isDark ? Colors.tealAccent : Colors.blueAccent,
                  textDecoration: TextDecoration.underline,
                ),
                "img": Style(
                  width: Width(double.infinity),
                  height: Height.auto(),
                  margin: Margins.symmetric(vertical: 8),
                ),
              },
              extensions: [
                TagExtension(
                  tagsToExtend: {"img"},
                  builder: (extensionContext) {
                    final src = extensionContext.attributes['src'] ?? '';
                    if (src.isEmpty) return const SizedBox.shrink();
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        src,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                              Icons.broken_image,
                              size: 60,
                              color: Colors.grey,
                            ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BannerAdsWidget(),
          PostActionButtons(
            postId: post.id,
            postTitle: post.title,
            postLink: 'https://baseprogrammer.com/posts/${post.id}',
          ),
        ],
      ),
    );
  }
}
