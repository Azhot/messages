import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messages/shared/constants.dart';

abstract class Styles {
  static void setSystemOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Constants.primaryColorDark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Constants.primaryColorLight,
      systemNavigationBarDividerColor: Constants.primaryColorLight,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
  }

  static ThemeData appTheme({Color primaryColor = Constants.primaryColor}) =>
      ThemeData(
          primaryColor: primaryColor,
          primaryColorLight: Constants.primaryColorLight,
          primaryColorDark: Constants.primaryColorDark,
          fontFamily: GoogleFonts.aBeeZee().fontFamily,
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: primaryColor,
                secondary: Constants.secondaryColor,
                primaryVariant: Constants.primaryColorLight,
                secondaryVariant: Constants.secondaryColorLight,
              ));

  static TextStyle appBarTextStyle() => GoogleFonts.aBeeZee(
        color: Constants.secondaryColor,
        fontSize: 18,
      );

  static TextStyle hintTextStyle({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
  }) =>
      GoogleFonts.aBeeZee(
        color: Constants.hintTextColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      );

  static TextStyle basicTextStyle({
    Color color = Constants.messageTextColor,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
  }) =>
      GoogleFonts.aBeeZee(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      );

  static TextStyle errorTextStyle({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
  }) =>
      GoogleFonts.aBeeZee(
        color: Constants.errorColor,
        fontSize: fontSize,
      );

  static InputDecoration textInputDecoration(String hintText) =>
      InputDecoration(
        hintText: hintText,
        hintStyle: hintTextStyle(),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: _outlineBorder(Constants.primaryColor),
        focusedBorder: _outlineBorder(Constants.primaryColorDark),
        errorBorder: _outlineBorder(Constants.errorColor),
        focusedErrorBorder: _outlineBorder(Constants.errorColor),
        errorStyle: errorTextStyle(fontSize: 12),
      );

  static OutlineInputBorder _outlineBorder(Color color) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
        ),
      );

  static ButtonStyle basicButtonStyle() => ElevatedButton.styleFrom(
        primary: Constants.primaryColorDark,
        textStyle: const TextStyle(color: Colors.white),
      );
}
