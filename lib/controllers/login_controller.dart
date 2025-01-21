import 'package:firebase/pages/home_page.dart';
import 'package:firebase/pages/signup_page.dart';
import 'package:get/get.dart';
import 'package:firebase/widgets/AppStyles.dart';
import '../service/auth_service.dart';

class LoginController extends GetxController {
  final _auth = AuthService();
  var isLoading = false.obs;
  var isEmailValid = true.obs;
  var isPasswordValid = true.obs;

  var email = ''.obs;
  var password = ''.obs;

  // Login with Email & Password
  Future<void> loginUserWithEmailAndPassword() async {
    isEmailValid.value = email.value.endsWith("@gmail.com");
    isPasswordValid.value = password.value.length >= 6;

    if (isEmailValid.value && isPasswordValid.value) {
      isLoading.value = true;

      final user = await _auth.loginUserWithEmailAndPassword(
        email.value,
        password.value,
      );

      if (user != null) {
        Get.snackbar(
          "Success",
          "Login successful!",
          backgroundColor: AppStyles.success,
          colorText: AppStyles.backGroundColor,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
        );
        goToHome();
      } else {
        Get.snackbar(
          "Error",
          "Login failed. Please try again.",
          backgroundColor: AppStyles.error,
          colorText: AppStyles.backGroundColor,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
        );
      }
      isLoading.value = false;
    } else {
      if (!isEmailValid.value) {
        Get.snackbar(
          "Invalid Email",
          "Please use a valid email ending with @gmail.com.",
          backgroundColor: AppStyles.error,
          colorText: AppStyles.backGroundColor,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
        );
      } else if (!isPasswordValid.value) {
        Get.snackbar(
          "Invalid Password",
          "Password must be at least 6 characters.",
          backgroundColor: AppStyles.error,
          colorText: AppStyles.backGroundColor,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
        );
      }
    }
  }

  // Google Login
  Future<void> loginWithGoogle() async {
    final user = await _auth.loginWithGoogle();
    if (user?.user != null) {
      Get.snackbar(
        "Success",
        "Login with Google successful!",
        backgroundColor: AppStyles.success,
        colorText: AppStyles.backGroundColor,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
      goToHome();
    } else {
      Get.snackbar(
        "Error",
        "Google login failed.",
        backgroundColor: AppStyles.error,
        colorText: AppStyles.backGroundColor,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
    }
  }

  // Navigation Methods
  void goToSignup() => Get.to(() => SignupPage());
  void goToHome() => Get.to(() => HomePage());
}
