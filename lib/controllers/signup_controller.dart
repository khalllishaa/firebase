import 'dart:developer';
import 'package:firebase/pages/home_page.dart';
import 'package:get/get.dart';
import '../service/auth_service.dart';
import '../widgets/AppStyles.dart';

class SignUpController extends GetxController {
  final AuthService _auth = AuthService();

  var name = ''.obs;
  var email = ''.obs;
  var password = ''.obs;

  var isEmailValid = true.obs;
  var isPasswordValid = true.obs;
  var isLoading = false.obs;

  Future<void> signup() async {
    isEmailValid.value = email.value.endsWith("@gmail.com");
    isPasswordValid.value = password.value.length >= 6;

    if (isEmailValid.value && isPasswordValid.value) {
      isLoading.value = true;

      final user = await _auth.createUserWithEmailAndPassword(
        email.value,
        password.value,
      );

      isLoading.value = false;

      if (user != null) {
        log("User Created Successfully");
        Get.snackbar(
          "Success",
          "Signup successful!",
          backgroundColor: AppStyles.success,
          colorText: AppStyles.backGroundColor,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
        Get.offAll(() => HomePage());
      } else {
        Get.snackbar(
          "Error",
          "Signup failed. Please try again.",
          backgroundColor: AppStyles.error,
          colorText: AppStyles.backGroundColor,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
      }
    } else {
      if (!isEmailValid.value) {
        Get.snackbar(
          "Invalid Email",
          "Please use a valid email ending with @gmail.com.",
          backgroundColor: AppStyles.error,
          colorText: AppStyles.backGroundColor,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
      }
      if (!isPasswordValid.value) {
        Get.snackbar(
          "Invalid Password",
          "Password must be at least 6 characters.",
          backgroundColor: AppStyles.error,
          colorText: AppStyles.backGroundColor,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
      }
    }
  }
}
