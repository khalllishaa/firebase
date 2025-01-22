import 'package:firebase/pages/signup_page.dart';
import 'package:firebase/widgets/AppStyles.dart';
import 'package:firebase/widgets/my_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';
import '../service/auth_service.dart';
import '../widgets/my_button.dart';
import '../widgets/my_text_field.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = AuthService();
  final _password = TextEditingController();
  final _email = TextEditingController();
  bool isLoading = false;
  bool _isEmailValid = true;
  bool _isPasswordValid = true;

  @override
  void dispose() {
    _password.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: AppStyles.heading1,
        ),
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
                controller: _email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email cannot be empty";
                  } else if (!value.contains("@gmail.com")) {
                    return "Email must be a valid @gmail.com address";
                  }
                  return null;
                },
              ),
              SizedBox(height: AppStyles.spaceXL),
              MyTextField(
                hintText: "Your Password",
                isObsecure: true,
                controller: _password,
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
              MyButton(
                text: "Login",
                color: AppStyles.textColor,
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;

                  // Validasi input email dan password
                  setState(() {
                    _isEmailValid = email.endsWith("@gmail.com");
                    _isPasswordValid = password.length >= 6;
                  });

                  if (_isEmailValid && _isPasswordValid) {
                    final user = await _auth.loginUserWithEmailAndPassword(
                      email,
                      password,
                    );
                    if (user != null) {
                      log("User Logged In");
                      Get.snackbar(
                        "Success",
                        "Login successful!",
                        backgroundColor: AppStyles.success,
                        colorText: AppStyles.backGroundColor,
                        snackPosition: SnackPosition.TOP,
                        duration: Duration(seconds: 3),
                      );
                      goToHome(context);
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
                  } else {
                    if (!_isEmailValid) {
                      Get.snackbar(
                        "Invalid Email",
                        "Please use a valid email ending with @gmail.com.",
                        backgroundColor: AppStyles.error,
                        colorText: AppStyles.backGroundColor,
                        snackPosition: SnackPosition.TOP,
                        duration: Duration(seconds: 3),
                      );
                    } else if (!_isPasswordValid) {
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
                },
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              SizedBox(height: AppStyles.spaceM),
              Text(
                "or",
                style: AppStyles.caption,
              ),
              SizedBox(height: AppStyles.spaceS),
              MyTextButton(
                onPressed: () async {
                  final user = await _auth.loginWithGoogle();

                  if (user?.user != null) {
                    log("User Logged In with Google");
                    showSnackbar(context, "Login with Google successful!");
                    goToHome(context);
                  } else {
                    showSnackbar(context, "Google login failed.");
                  }
                },
              ),
              SizedBox(height: AppStyles.spaceL),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: AppStyles.caption,
                  ),
                  SizedBox(width: AppStyles.spaceXS),
                  InkWell(
                    onTap: () => goToSignup(context),
                    child: Text(
                      "Sign Up",
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

  void goToSignup(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SignupPage()),
  );

  void goToHome(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomePage()),
  );

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
