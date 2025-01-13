import 'package:firebase/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import '../auth_service.dart';
import '../widgets/AppStyles.dart';
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
        title: Text('Login', style: AppStyles.heading1),
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
              ),
              SizedBox(height: AppStyles.spaceM),
              MyTextField(
                hintText: "Your Password",
                isObsecure: true,
                controller: _password,
              ),
              SizedBox(height: AppStyles.spaceXL),
              MyButton(
                text: "Login",
                color: AppStyles.textColor,
                onPressed: _login,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              SizedBox(height: AppStyles.spaceS),
              Text('Or', style: AppStyles.caption),
              SizedBox(height: AppStyles.spaceS),
              isLoading
                  ?const CircularProgressIndicator():
              MyButton(
                text: 'Signin with Google',
                color: AppStyles.textColor,
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
              SizedBox(height: AppStyles.spaceS),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have ann account?", style: AppStyles.caption),
                  SizedBox(height: AppStyles.spaceXS),
                  InkWell(
                    onTap: () => goToSignup(context),
                    child: Text('Sign up', style: AppStyles.inkwell),
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
    MaterialPageRoute(builder: (context) => const HomePage()),
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
