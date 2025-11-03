import 'package:baseprogrammer/views/post_detail_screen.dart';
import 'package:baseprogrammer/views/post_list_screen.dart';
import 'package:get/get.dart';
import '../bindings/post_binding.dart';
part 'app_routes.dart';


class AppPages {
static final pages = [
GetPage(
name: Routes.HOME,
page: () => const PostListScreen(),
binding: PostBinding(),
),
GetPage(
name: Routes.DETAIL,
page: () => PostDetailScreen(post: Get.arguments),
),
];
}