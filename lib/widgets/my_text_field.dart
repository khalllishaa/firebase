import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'AppStyles.dart';

class MyTextField extends StatefulWidget {
  final String hintText;
  final bool isObsecure;
  final TextEditingController? controller;
  final String? Function(String?)? validator; // Validator function
  const MyTextField({
    super.key,
    required this.hintText,
    required this.isObsecure,
    this.controller,
    this.validator,
  });

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: AppStyles.paddingS),
      decoration: BoxDecoration(
        color: AppStyles.backGroundColor,
        borderRadius: BorderRadius.circular(AppStyles.radiusS),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: widget.controller,
            onChanged: (value) {
              if (widget.validator != null) {
                setState(() {
                  errorText = widget.validator!(value);
                });
              }
            },
            decoration: InputDecoration(
              hintText: widget.hintText,
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
                  color: errorText == null ? Colors.green : Colors.red,
                  width: 3.0,
                ),
                borderRadius: BorderRadius.circular(AppStyles.radiusM),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: errorText == null
                      ? AppStyles.backGroundColor
                      : Colors.red,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(AppStyles.radiusM),
              ),
            ),
            style: GoogleFonts.poppins(
              color: AppStyles.textColor,
            ),
            obscureText: widget.isObsecure,
          ),
          if (errorText != null)
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 4.0),
              child: Text(
                errorText!,
                style: GoogleFonts.poppins(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
