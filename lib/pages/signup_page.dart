import 'dart:developer';

import 'package:firebase/pages/home.dart';
import 'package:firebase/pages/home_page.dart';
import 'package:firebase/pages/login_page.dart';
import 'package:flutter/material.dart';

import '../auth_service.dart';
import '../widgets/color.dart';
import '../widgets/my_button.dart';
import '../widgets/my_text.dart';
import '../widgets/my_text_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _auth = AuthService();
  final _name = TextEditingController();
  final _password = TextEditingController();
  final _email = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _password.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(text: "Sign Up", color: textColor, fontsize: 18, fontWeight: FontWeight.bold),
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
                fontsize: 15,
                controller: _name,
              ),
              const SizedBox(height: 16),
              MyTextField(
                hintText: "Your Email",
                isObsecure: false,
                fontsize: 15,
                controller: _email,
              ),
              const SizedBox(height: 16),
              MyTextField(
                hintText: "Your Password",
                isObsecure: true,
                fontsize: 15,
                controller: _password,
              ),
              const SizedBox(height: 30),
              MyButton(
                text: "Signup",
                color: textColor,
                onPressed: _signup,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(
                    text: "Already have an account?",
                    color: textColor,
                    fontsize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () => goToLogin(context),
                    child: MyText(
                      text: "Login",
                      color: higlightColor,
                      fontsize: 12,
                      fontWeight: FontWeight.bold,
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

  void goToLogin(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const LoginPage()),
  );

  void goToHome(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Home()),
  );

  Future<void> _signup() async {
    final user =
    await _auth.createUserWithEmailAndPassword(_email.text, _password.text);

    if (user != null) {
      log("User Created Successfully");
      goToHome(context);
    }
  }
}
