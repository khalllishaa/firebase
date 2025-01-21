import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase/widgets/AppStyles.dart';
import 'package:firebase/widgets/my_button.dart';
import '../controllers/signup_controller.dart';
import '../route/app_route.dart';
import '../widgets/my_text_field.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up", style: AppStyles.heading1),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyTextField(
                hintText: "Your Name",
                isObsecure: false,
                onChanged: (value) => controller.name.value = value,
              ),
              SizedBox(height: AppStyles.spaceS),
              MyTextField(
                hintText: "Your Email",
                isObsecure: false,
                onChanged: (value) => controller.email.value = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email cannot be empty";
                  } else if (!value.contains("@gmail.com")) {
                    return "Email must be a valid @gmail.com address";
                  }
                  return null;
                },
              ),
              SizedBox(height: AppStyles.spaceS),
              MyTextField(
                hintText: "Your Password",
                isObsecure: true,
                onChanged: (value) => controller.password.value = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password cannot be empty";
                  } else if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),
              SizedBox(height: AppStyles.spaceXL),
              Obx(() => MyButton(
                text: controller.isLoading.value ? "Signing Up..." : "Sign Up",
                color: AppStyles.textColor,
                onPressed: controller.isLoading.value
                    ? () {} // Provide an empty function if the button is disabled
                    : () {
                  controller.signup();
                },
                fontSize: 14,
                fontWeight: FontWeight.normal,
              )),

              SizedBox(height: AppStyles.spaceL),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already Have an Account?",
                    style: AppStyles.caption,
                  ),
                  SizedBox(width: AppStyles.spaceXS),
                  InkWell(
                    onTap: () => Get.toNamed(AppRoute.login),
                    child: Text(
                      "Login",
                      style: AppStyles.inkwell,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
