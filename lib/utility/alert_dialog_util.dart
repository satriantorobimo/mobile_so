import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAlertDialog extends StatelessWidget {
  final Color bgColor;
  final String title;
  final String message;
  final String positiveBtnText;
  final String negativeBtnText;
  final Function onPostivePressed;
  final Function onNegativePressed;
  final double circularBorderRadius;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.message,
    this.circularBorderRadius = 15.0,
    this.bgColor = Colors.white,
    required this.positiveBtnText,
    required this.negativeBtnText,
    required this.onPostivePressed,
    required this.onNegativePressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title,
          style: TextStyle(
            fontFamily: GoogleFonts.poppins().fontFamily,
          )),
      content: Text(message,
          style: TextStyle(
            fontFamily: GoogleFonts.poppins().fontFamily,
          )),
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circularBorderRadius)),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            onNegativePressed();
          },
          child: Text(negativeBtnText,
              style: TextStyle(
                fontFamily: GoogleFonts.poppins().fontFamily,
              )),
        ),
        TextButton(
          onPressed: () {
            onPostivePressed();
          },
          child: Text(positiveBtnText,
              style: TextStyle(
                fontFamily: GoogleFonts.poppins().fontFamily,
              )),
        ),
      ],
    );
  }
}
