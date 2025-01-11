import 'package:firebase/pages/login_page.dart';
import 'package:firebase/widgets/My_Button.dart';
import 'package:firebase/widgets/color.dart';
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
          mainAxisAlignment: MainAxisAlignment.center, // Pusatkan widget di tengah layar
          mainAxisSize: MainAxisSize.min,
          children: [
            // Tambahkan sedikit jarak antar widget jika diperlukan
            MyButton(
              text: "Logout",
              color: textColor,
              onPressed: () async {
                await auth.signout();
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

