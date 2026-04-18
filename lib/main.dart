import 'package:baseprogrammer/controllers/theme_controller.dart';
import 'package:baseprogrammer/routes/app_pages.dart';
import 'package:baseprogrammer/theme/app_theme.dart';
import 'package:baseprogrammer/services/ads/ad_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await MobileAds.instance.initialize();

  // 🛠️ Test Device Configuration
  // Jab aapko console se ID mil jaye, toh use niche paste karein.
  // MobileAds.instance.updateRequestConfiguration(
  //   RequestConfiguration(
  //     testDeviceIds: [
  //       "3BA91F4D77A04D7830F66C17A3268834", // <-- Console se mila hua 32-char ID yahan dalein
  //     ],
  //   ),
  // );

  // Initialize AdService
  Get.put(AdService());

  runApp(const BaseProgrammerApp());
}

class BaseProgrammerApp extends StatelessWidget {
  const BaseProgrammerApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initializing ThemeController globally
    final ThemeController themeController = Get.put(ThemeController());

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Obx(
          () => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Base Programmer',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeController.isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,
            initialRoute: Routes.SPLASH,
            getPages: AppPages.pages,
          ),
        );
      },
    );
  }
}
