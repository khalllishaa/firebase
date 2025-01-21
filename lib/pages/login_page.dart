import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase/widgets/AppStyles.dart';
import 'package:firebase/widgets/my_text_button.dart';
import '../controllers/login_controller.dart';
import '../route/app_route.dart';
import '../widgets/my_button.dart';
import '../widgets/my_text_field.dart'; // Import LoginController

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the controller that has been injected via Binding
    final LoginController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text("Login", style: AppStyles.heading1),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyTextField(
                  hintText: "Your Email",
                  isObsecure: false,
                  onChanged: (value) => controller.email.value = value,
                ),
                SizedBox(height: AppStyles.spaceS),
                MyTextField(
                  hintText: "Your Password",
                  isObsecure: true,
                  onChanged: (value) => controller.password.value = value,
                ),
                SizedBox(height: AppStyles.spaceXL),
                Obx(() => MyButton(
                  text: controller.isLoading.value ? "Logging In..." : "Login",
                  color: AppStyles.textColor,
                  onPressed: () async {
                    await controller.loginUserWithEmailAndPassword();
                  },
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                )),
                SizedBox(height: AppStyles.spaceM),
                Text("or", style: AppStyles.caption),
                SizedBox(height: AppStyles.spaceS),
                MyTextButton(onPressed: controller.loginWithGoogle),
                SizedBox(height: AppStyles.spaceL),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?", style: AppStyles.caption),
                    SizedBox(width: AppStyles.spaceXS),
                    InkWell(
                      onTap: () => Get.toNamed(AppRoute.signup),
                      child: Text("Sign Up", style: AppStyles.inkwell),
                    ),
                  ],
                ),
              ],
            )
        ),
      ),
    );
  }
}
