import 'package:firebase/widgets/AppStyles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextButton extends StatelessWidget {
  final VoidCallback onPressed;

  const MyTextButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 41,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: AppStyles.backGroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppStyles.radiusS),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image/google.png',
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 8),
            Text("Sign in with Google",
                style: GoogleFonts.poppins(
                  color: AppStyles.textColor,
                )),
          ],
        ),
      ),
    );
  }
}
