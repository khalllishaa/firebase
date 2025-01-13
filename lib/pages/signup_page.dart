import 'package:flutter/material.dart';
import '../auth_service.dart';
import '../widgets/AppStyles.dart';
import '../widgets/my_button.dart';
import '../widgets/my_text_field.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _auth = AuthService();
    final _email = TextEditingController();
    final _password = TextEditingController();
    final _name = TextEditingController();

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
                onPressed: () async {
                  await _auth.createUserWithEmailAndPassword(
                      _email.text, _password.text, context);
                },
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              SizedBox(height: AppStyles.spaceL),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?', style: AppStyles.caption),
                  SizedBox(width: AppStyles.spaceXS),
                  InkWell(
                    onTap: () => _auth.navigateToLogin(context),
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
}
