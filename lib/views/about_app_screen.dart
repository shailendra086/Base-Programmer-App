import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  // 🔗 URLs
  final String linkedinUrl = "https://www.linkedin.com/in/shailendra009/";
  final String githubUrl = "https://github.com/shailendra086";
  final String websiteUrl = "https://baseprogrammer.com";

  // 🌐 URL Launcher
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Get.snackbar("Error", "Could not open $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);


    return Scaffold(
      appBar: AppBar(title: const Text("About App")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ App Logo
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: theme.primaryColor.withOpacity(0.2),
                child: Icon(Icons.apps, size: 50, color: theme.primaryColor),
              ),
            ),

            const SizedBox(height: 20),

            // ✅ App Name
            Center(
              child: Text(
                "Base Programmer",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // ✅ Description Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: theme.cardColor,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Base Programmer is a modern Flutter blog app powered by the WordPress REST API.\n\n"
                  "This app provides tech tutorials, programming blogs, and real-time updates directly from BaseProgrammer.com.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 14, height: 1.4),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // ✅ Author Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: theme.cardColor,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      child: ClipOval(
                        child: Image.network(
                          "https://avatars.githubusercontent.com/u/86818577?v=4",
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.person, size: 28),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Shailendra Sahani",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Flutter Developer",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ✅ Social Links Section
            Text(
              "Connect with me",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _socialButton(
                  icon: Icons.language,
                  color: Colors.blueAccent,
                  text: "Website",
                  onTap: () => _launchURL(websiteUrl),
                ),
                _socialButton(
                  icon: Icons.linked_camera,
                  color: Colors.blue,
                  text: "LinkedIn",
                  onTap: () => _launchURL(linkedinUrl),
                ),
                _socialButton(
                  icon: Icons.code,
                  color: Colors.black,
                  text: "GitHub",
                  onTap: () => _launchURL(githubUrl),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ✅ Reusable Social Button
  Widget _socialButton({
    required IconData icon,
    required Color color,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 6),
          Text(text, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
