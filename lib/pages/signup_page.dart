import 'dart:developer';

import 'package:firebase/pages/home_page.dart';
import 'package:firebase/pages/login_page.dart';
import 'package:flutter/material.dart';

import '../auth_service.dart';
import '../widgets/AppStyles.dart';
import '../widgets/my_button.dart';
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
        title: Text('Sign Up', style: AppStyles.heading1),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppStyles.paddingL),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyTextField(
                hintText: "Your Name",
                isObsecure: false,
                controller: _name,
              ),
              SizedBox(height: AppStyles.spaceM),
              MyTextField(
                hintText: "Your Email",
                isObsecure: false,
                controller: _email,
              ),
              SizedBox(height: AppStyles.spaceM),
              MyTextField(
                hintText: "Your Password",
                isObsecure: true,
                controller: _password,
              ),
              SizedBox(height: AppStyles.spaceXL),
              MyButton(
                text: "Signup",
                color: AppStyles.textColor,
                onPressed: _signup,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              SizedBox(height: AppStyles.spaceL),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account', style: AppStyles.caption),
                  SizedBox(height: AppStyles.spaceXS),
                  InkWell(
                    onTap: () => goToLogin(context),
                    child: Text('Login', style: AppStyles.inkwell),
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
    MaterialPageRoute(builder: (context) => const HomePage()),
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
