
import 'package:firebase/pages/signup_page.dart';
import 'package:firebase/widgets/AppStyles.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import '../auth_service.dart';
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
        title: Text("Login", style: AppStyles.heading1,)
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
              const SizedBox(height: 16),
              MyTextField(
                hintText: "Your Password",
                isObsecure: true,
                controller: _password,
              ),
              const SizedBox(height: 30),
              MyButton(
                text: "Login",
                color: AppStyles.textColor,
                onPressed: () async {
                  final user = await _auth.loginUserWithEmailAndPassword(
                      _email.text,
                      _password.text
                  );

                  if (user != null) {
                    log("User Logged In");
                    goToHome(context);
                  }
                },
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),

              const SizedBox(height: 10),
            Text("or", style: AppStyles.caption,),
               SizedBox(height: 10),

              MyButton(
                text: 'Signin with Google',
                color: AppStyles.textColor,
                onPressed: () async {
                  final user = await _auth.loginWithGoogle();

                  if (user?.user != null) {
                    log("User Logged In with Google");
                    goToHome(context);
                  }
                },
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have account?", style: AppStyles.caption,),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () => goToSignup(context),
                    child: Text("Sign Up", style: AppStyles.inkwell,)
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void goToSignup(BuildContext context) =>
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignupPage()),
      );

  void goToHome(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Home()),
  );
}


