import 'dart:developer';

import 'package:firebase/pages/home_page.dart';
import 'package:firebase/pages/login_page.dart';
import 'package:firebase/widgets/AppStyles.dart';
import 'package:flutter/material.dart';

import '../service/auth_service.dart';
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
        title: Text("Sign Up", style: AppStyles.heading1,)
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
                controller: _name,
              ),
              const SizedBox(height: 16),
              MyTextField(
                hintText: "Your Email",
                isObsecure: false,
                controller: _email,
              ),
              const SizedBox(height: 16),
              MyTextField(
                hintText: "Your Password",
                isObsecure: true,
                controller: _password,
              ),
              const SizedBox(height: 30),
              MyButton(
                text: "Signup",
                color: AppStyles.textColor,
                onPressed: _signup,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already Have an Account?", style: AppStyles.caption,),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () => goToLogin(context),
                    child: Text("Login", style: AppStyles.inkwell,)
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

  void goToHome(BuildContext context) => Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) =>  Home()),
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

