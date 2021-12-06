import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messages/constants.dart';
import 'package:messages/service/auth_service.dart';

class MessagesAppBar extends AppBar {
  // constants
  static const String _signOut = 'Sign Out';
  static const String _settings = 'Settings';

  // constructor
  MessagesAppBar(title, {Key? key})
      : super(
          key: key,
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: _onMenuItemSelected,
              itemBuilder: (BuildContext context) {
                return {_signOut, _settings}
                    .map((String choice) => PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        ))
                    .toList();
              },
            ),
          ],
          title: Text(
            title,
            style: GoogleFonts.aBeeZee(
              color: Constants.secondaryColor,
              fontSize: 18,
            ),
          ),
          backgroundColor: Constants.primaryColor,
        );

  // private functions
  static void _onMenuItemSelected(String value) async {
    switch (value) {
      case _signOut:
        await AuthService.signOut();
        break;
      case _settings:
        break;
    }
  }
}
