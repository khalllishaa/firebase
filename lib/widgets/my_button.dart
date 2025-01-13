import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'AppStyles.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  final double fontSize;
  final FontWeight fontWeight;
  const MyButton({super.key, required this.text, required this.color, required this.onPressed, required this.fontSize, required this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: AppStyles.paddingS),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: AppStyles.textColor,
              padding: const EdgeInsets.symmetric(horizontal: AppStyles.paddingL, vertical: AppStyles.paddingM),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppStyles.radiusS))),
          child: Text(
            text,
            style: GoogleFonts.poppins(color: AppStyles.backGroundColor, fontSize: fontSize, fontWeight: fontWeight),
          )),
    );
  }
}
