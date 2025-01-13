import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'AppStyles.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool isObsecure;
  final TextEditingController? controller;
  const MyTextField(
      {super.key,
        required this.hintText,
        required this.isObsecure,
        this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: AppStyles.paddingS),
      decoration: BoxDecoration(
        color: AppStyles.backGroundColor,
        borderRadius: BorderRadius.circular(AppStyles.radiusS),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            color: AppStyles.textColor,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppStyles.paddingL,
            vertical: AppStyles.paddingXL,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppStyles.textColor,
              width: 3.0,
            ),
            borderRadius: BorderRadius.circular(AppStyles.radiusM),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppStyles.backGroundColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(AppStyles.radiusM),
          ),
        ),
        style: GoogleFonts.poppins(
          color: AppStyles.textColor,
        ),
        obscureText: isObsecure,
      ),
    );
  }
}
