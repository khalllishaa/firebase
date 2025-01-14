import 'package:firebase/pages/home.dart';
import 'package:firebase/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import '../auth_service.dart';
import '../widgets/color.dart';
import '../widgets/my_button.dart';
import '../widgets/my_text.dart';
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
        title: MyText(
          text: "Login",
          color: textColor,
          fontsize: 18,
          fontWeight: FontWeight.bold,
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
                fontsize: 14,
                controller: _email,
              ),
              const SizedBox(height: 16),
              MyTextField(
                hintText: "Your Password",
                isObsecure: true,
                fontsize: 14,
                controller: _password,
              ),
              const SizedBox(height: 30),
              MyButton(
                text: "Login",
                color: textColor,
                onPressed: _login,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              const SizedBox(height: 10),
              MyText(
                text: "Or",
                color: textColor,
                fontsize: 12,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 10),
              isLoading
                  ?const CircularProgressIndicator():
              MyButton(
                text: 'Signin with Google',
                color: textColor,
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await _auth.loginWithGoogle();
                  setState(() {
                    isLoading = false;
                  });
                },
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(
                    text: "Don't have an account?",
                    color: textColor,
                    fontsize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () => goToSignup(context),
                    child: MyText(
                      text: "Sign Up",
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

  void goToSignup(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const SignupPage()),
  );

  void goToHome(BuildContext context) => Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const Home()),
  );

  Future<void> _login() async {
    final user =
    await _auth.loginUserWithEmailAndPassword(_email.text, _password.text);

    if (user != null) {
      log("User Logged In");
      goToHome(context);
    }
  }

  Future<void> _loginWithGoogle() async {
    final user = await _auth.loginWithGoogle();

    if (user?.user != null) {
      log("User Logged In with Google");
      goToHome(context);
    }
  }
}
