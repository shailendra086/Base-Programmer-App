import 'package:baseprogrammer/controllers/theme_controller.dart';
import 'package:baseprogrammer/theme/app_theme.dart';
import 'package:baseprogrammer/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await GetStorage.init();
  runApp(const BaseProgrammerApp());
}

class BaseProgrammerApp extends StatelessWidget {
  const BaseProgrammerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());

    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Base Programmer',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeController.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: const SplashScreen(),
        ));
  }
}
