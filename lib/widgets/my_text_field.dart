import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool isObsecure;
  final double fontsize;
  final TextEditingController? controller;
  const MyTextField(
      {super.key,
        required this.hintText,
        required this.isObsecure,
        required this.fontsize,
        this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: backGroundColor,
        borderRadius: BorderRadius.circular((8)),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            color: textColor,
            fontSize: fontsize,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: textColor,
              width: 3.0,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: backGroundColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        style: GoogleFonts.poppins(
          color: textColor,
        ),
        obscureText: isObsecure,
      ),
    );
  }
}
