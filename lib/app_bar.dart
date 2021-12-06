import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messages/shared/constants.dart';
import 'package:messages/service/auth_service.dart';
import 'package:messages/shared/strings.dart';

class MessagesAppBar extends AppBar {
  // constructor
  MessagesAppBar(title, {Key? key})
      : super(
          key: key,
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: _onMenuItemSelected,
              itemBuilder: (BuildContext context) {
                return {Strings.signOut, Strings.settings}
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
      case Strings.signOut:
        await AuthService.signOut();
        break;
      case Strings.settings:
        break;
    }
  }
}
