import 'package:get/get.dart';
import '../pages/login_page.dart';
import '../pages/signup_page.dart';
import '../binding/login_binding.dart';
import '../binding/signup_binding.dart';

class AppRoute {
  static const login = '/login';
  static const signup = '/signup';
}

class AppPage {
  static final pages = [
    GetPage(
      name: AppRoute.login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoute.signup,
      page: () => SignupPage(),
      binding: SignUpBinding(),
    ),
  ];
}
