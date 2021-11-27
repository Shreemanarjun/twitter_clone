import 'package:get/get.dart';
import 'package:twitter_clone/controller/authcontroller.dart';
import 'package:twitter_clone/controller/twittercontroller.dart';
import 'package:twitter_clone/middleware/authguard.dart';
import 'package:twitter_clone/pages/homepage/homepage.dart';
import 'package:twitter_clone/pages/signinpage/googlesigninpage.dart';

part './app_routes.dart';

abstract class AppPages {
  static const initial = "/login";
  static final pages = [
    GetPage(
        name: Routes.startpage,
        page: () => GoogleSignInPage(),
        binding: BindingsBuilder.put(() => AuthController()),
        middlewares: [AuthGuard()]),
    GetPage(
      name: Routes.homepage,
      page: () => HomePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AuthController());
        Get.lazyPut(() => TwitterController());
      }),
      middlewares: [AuthGuard()],
    ),
  ];
}
