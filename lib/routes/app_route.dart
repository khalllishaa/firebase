import 'package:firebase/binding/notes_binding.dart';
import 'package:firebase/pages/notes.dart';
import 'package:get/get.dart';
import '../pages/login_page.dart';
import '../pages/signup_page.dart';
import '../binding/login_binding.dart';
import '../binding/signup_binding.dart';

class AppRoute {
  static const login = '/login';
  static const signup = '/signup';
  static const note = '/note';
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
    GetPage(
      name: AppRoute.note,
      page: () => Note(),
      binding: NotesBinding(),
    ),
  ];
}