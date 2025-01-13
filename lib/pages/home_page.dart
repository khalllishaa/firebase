import 'package:firebase/pages/login_page.dart';
import 'package:firebase/widgets/My_Button.dart';
import 'package:firebase/widgets/AppStyles.dart';
import 'package:flutter/material.dart';

import '../auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            MyButton(
              text: "Logout",
              color: AppStyles.textColor,
              onPressed: () async {
                await auth.signOut();
                goToLogin(context);
              },
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ],
        ),
      ),
    );
  }

  void goToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
}

