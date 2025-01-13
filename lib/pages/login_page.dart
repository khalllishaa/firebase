import 'package:flutter/material.dart';
import '../auth_service.dart';
import '../widgets/AppStyles.dart';
import '../widgets/my_button.dart';
import '../widgets/my_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _auth = AuthService();
    final _email = TextEditingController();
    final _password = TextEditingController();

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
                onPressed: () async {
                  await _auth.loginUserWithEmailAndPassword(
                      _email.text, _password.text,);
                },
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              SizedBox(height: AppStyles.spaceS),
              Text('Or', style: AppStyles.caption),
              SizedBox(height: AppStyles.spaceS),
              MyButton(
                text: 'Signin with Google',
                color: AppStyles.textColor,
                onPressed: () async {
                  await _auth.loginWithGoogle(context);
                },
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              SizedBox(height: AppStyles.spaceS),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?", style: AppStyles.caption),
                  SizedBox(width: AppStyles.spaceXS),
                  InkWell(
                    onTap: () => _auth.navigateToSignup(context),
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
}
