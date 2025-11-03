import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';
import 'post_list_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  void initState() {
    super.initState();
    // ⏳ Navigate after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Get.off(() => const PostListScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = themeController.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? Colors.deepPurple.shade900 : Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🌀 Logo
            Icon(
              Icons.code_rounded,
              size: 90,
              color: isDark ? Colors.white : Colors.blueAccent,
            ),
            const SizedBox(height: 20),

            // 🧾 App Title
            Text(
              "Base Programmer",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Designed by Shailendra Sahani",
              style: TextStyle(
                color: isDark ? Colors.white70 : Colors.black54,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 40),

            // 🔄 Loading Indicator
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
