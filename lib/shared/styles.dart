import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messages/shared/constants.dart';

class Styles {
  static TextStyle appBarTextStyle() => GoogleFonts.aBeeZee(
        color: Constants.secondaryColor,
        fontSize: 18,
      );

  static TextStyle hintTextStyle() => GoogleFonts.aBeeZee(
        color: Constants.hintTextColor,
        fontSize: 14,
      );

  static TextStyle basicTextStyle() => GoogleFonts.aBeeZee(
        color: Constants.messageTextColor,
        fontSize: 14,
      );

  static TextStyle errorTextStyle() => GoogleFonts.aBeeZee(
        color: Constants.errorColor,
        fontSize: 12,
      );

  static InputDecoration textInputDecoration(String text) => InputDecoration(
        hintText: text,
        hintStyle: hintTextStyle(),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: _outlineBorder(Constants.primaryColor),
        focusedBorder: _outlineBorder(Constants.secondaryColor),
        errorBorder: _outlineBorder(Constants.errorColor),
        focusedErrorBorder: _outlineBorder(Constants.errorColor),
        errorStyle: errorTextStyle(),
      );

  static OutlineInputBorder _outlineBorder(Color color) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
        ),
      );

  static ButtonStyle basicButtonStyle() => ElevatedButton.styleFrom(
        primary: Constants.secondaryColor,
        textStyle: const TextStyle(color: Colors.white),
      );
}
