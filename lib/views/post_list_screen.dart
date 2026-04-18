import 'package:baseprogrammer/controllers/post_controller.dart';
import 'package:baseprogrammer/controllers/theme_controller.dart';
import 'package:baseprogrammer/controllers/network_controller.dart';
import 'package:baseprogrammer/services/ads/ad_service.dart';
import 'package:baseprogrammer/services/ads/banner_ads.dart';
import 'package:baseprogrammer/services/ads/native_ads_widget.dart';
import 'package:baseprogrammer/widgets/no_internet_widget.dart';
import 'package:baseprogrammer/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'post_detail_screen.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PostController controller = Get.put(PostController());
    final ThemeController themeController = Get.find<ThemeController>();
    final NetworkController networkController = Get.put(NetworkController());
    final AdService adService = Get.find<AdService>();

    return Scaffold(
      drawer: const SideBar(),
      appBar: AppBar(
        title: const Text('Base Programmer'),
        backgroundColor: themeController.isDarkMode
            ? Colors.deepPurple.shade400
            : Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              themeController.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: Colors.white,
            ),
            onPressed: themeController.toggleTheme,
          ),
        ],
      ),
      bottomNavigationBar: const BannerAdsWidget(),
      body: Obx(() {
        // 🔌 Check Network
        if (!networkController.isConnected.value) {
          return NoInternetWidget(onRetry: () => controller.fetchPosts());
        }

        if (controller.isLoading.value && controller.posts.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.error.isNotEmpty) {
          return Center(child: Text(controller.error.value));
        }

        if (controller.posts.isEmpty) {
          return const Center(child: Text('No posts found.'));
        }

        // Calculate total item count including native ads (one every 6 posts)
        const int adInterval = 6;
        int adCount = controller.posts.length ~/ adInterval;
        int totalItemCount = controller.posts.length + adCount + 1; // +1 for Load More

        return RefreshIndicator(
          onRefresh: () => controller.fetchPosts(),
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: totalItemCount,
            itemBuilder: (context, index) {
              // 🔽 Load More Button at the end
              if (index == totalItemCount - 1) {
                if (!controller.hasMore.value) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: Text('No more posts')),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : ElevatedButton.icon(
                            onPressed: () =>
                                controller.fetchPosts(loadMore: true),
                            icon: const Icon(Icons.arrow_downward, size: 18),
                            label: const Text('Load More'),
                          ),
                  ),
                );
              }

              // 📢 Native Ad Insertion
              if (index != 0 && (index + 1) % (adInterval + 1) == 0) {
                return const NativeAdsWidget();
              }

              // 📜 Post Item
              // Calculate correct post index by subtracting number of ads shown before this index
              int adsShownBefore = (index + 1) ~/ (adInterval + 1);
              int postIndex = index - adsShownBefore;

              if (postIndex >= controller.posts.length) return const SizedBox.shrink();

              final post = controller.posts[postIndex];
              final formattedDate = _formatDate(post.date);

              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    // Show Interstitial Ad before navigating
                    adService.showInterstitialAd();
                    Get.to(() => PostDetailScreen(post: post));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 🖼️ Thumbnail
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: post.imageUrl.isNotEmpty
                              ? Image.network(
                                  post.imageUrl,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                          Container(
                                            width: 100,
                                            height: 100,
                                            color: Colors.grey[300],
                                            child: const Icon(
                                              Icons.broken_image,
                                              size: 40,
                                              color: Colors.grey,
                                            ),
                                          ),
                                )
                              : Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.grey[300],
                                  child: const Icon(
                                    Icons.image_not_supported,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                ),
                        ),
                        const SizedBox(width: 10),

                        // 📜 Post Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 🏷️ Title
                              Text(
                                post.title,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface.withOpacity(0.9),
                                ),
                              ),
                              const SizedBox(height: 6),

                              // 👤 Author & Date
                              Wrap(
                                spacing: 15,
                                runSpacing: 4,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.person,
                                        size: 14,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary
                                            .withOpacity(0.7),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        post.authorName.isNotEmpty
                                            ? post.authorName
                                            : 'Unknown',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withOpacity(0.7),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        size: 14,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary
                                            .withOpacity(0.7),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        formattedDate,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withOpacity(0.7),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (_) {
      return 'Unknown';
    }
  }
}
