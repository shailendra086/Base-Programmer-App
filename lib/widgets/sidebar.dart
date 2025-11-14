import 'package:baseprogrammer/views/about_app_screen.dart';
import 'package:baseprogrammer/views/liked_posts_screen.dart';
import 'package:baseprogrammer/views/saved_posts_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/theme_controller.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    final bool isDark = themeController.isDarkMode;

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [Colors.deepPurple.shade400, Colors.deepPurple.shade700]
                      : [Colors.blueAccent, Colors.blue.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/86818577?v=4',
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Base Programmer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'https://baseprogrammer.com',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // ✅ Menu Section
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // ✅ Home
                  _drawerItem(
                    icon: Icons.home,
                    text: 'Home',
                    onTap: () => Get.back(),
                    context: context,
                  ),

                  // ✅ Saved Posts
                  _drawerItem(
                    icon: Icons.bookmark,
                    text: 'Saved Posts',
                    onTap: () {
                      Get.back(); // close the drawer
                      Get.to(() => const SavedPostsScreen(),
                          transition: Transition.fadeIn);
                    },
                    context: context,
                  ),

                  // ✅ Liked Posts
                  _drawerItem(
                    icon: Icons.favorite,
                    text: 'Liked Posts',
                    onTap: () {
                      Get.back();
                      Get.to(() => const LikedPostsScreen(),
                          transition: Transition.fadeIn);
                    },
                    context: context,
                  ),

                  // ✅ About
                  _drawerItem(
                    icon: Icons.info_outline,
                    text: 'About App',
                    onTap: () {
                      Get.back();
                      Get.to(() => const AboutAppScreen());
                    },
                    context: context,
                  ),


                  const Divider(height: 30),

                  // ✅ Theme Toggle
                  Obx(
                        () => SwitchListTile(
                      title: const Text('Dark Mode'),
                      secondary: Icon(
                        themeController.isDarkMode
                            ? Icons.dark_mode
                            : Icons.light_mode,
                      ),
                      value: themeController.isDarkMode,
                      onChanged: (value) => themeController.toggleTheme(),
                    ),
                  ),

                  // // ✅ Exit
                  // _drawerItem(
                  //   icon: Icons.logout,
                  //   text: 'Exit',
                  //   onTap: () => Get.back(),
                  //   context: context,
                  // ),
                ],
              ),
            ),

            const Divider(height: 1),

            // ✅ Footer
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.deepPurple.withOpacity(0.2)
                    : Colors.blue.withOpacity(0.1),
              ),
              child: Center(
                child: Text(
                  'Designed by Shailendra Sahani',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: isDark
                        ? Colors.white70
                        : Colors.black.withOpacity(0.7),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Drawer Item Builder
  Widget _drawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      hoverColor: Theme.of(context).primaryColor.withOpacity(0.1),
    );
  }
}
