import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messages/constants.dart';
import 'package:messages/service/auth_service.dart';

class SignIn extends StatefulWidget {
  // variables
  final Function _toggleView;

  const SignIn(this._toggleView, {Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // constants
  static const String _signIn = 'Sign in';
  static const String _register = 'Register';
  static const String _emailText = 'Enter an e-mail';
  static const String _passwordText = 'Enter a password 6+ chars long';
  static const String _invalidCredentials =
      'Could not sign in with those credentials';

  // state variables
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _error = '';

  // overrides
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: appBar(),
        body: body(),
      );

  // widgets
  AppBar appBar() => AppBar(
        title: Text(
          Constants.signInPageTitle,
          style: appBarTextStyle(),
        ),
        backgroundColor: Constants.primaryColor,
        actions: menu(),
      );

  List<Widget> menu() => [
        PopupMenuButton(
            onSelected: _onMenuItemSelected,
            itemBuilder: (BuildContext context) {
              return {_register}
                  .map((String choice) => PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      ))
                  .toList();
            })
      ];

  Container body() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            spacer(),
            emailField(),
            spacer(),
            passwordField(),
            spacer(),
            validateButton(),
            spacer(),
            emailErrorText()
          ],
        ),
      ),
    );
  }

  SizedBox spacer() => const SizedBox(height: 16);

  TextStyle appBarTextStyle() => GoogleFonts.aBeeZee(
        color: Constants.secondaryColor,
        fontSize: 18,
      );

  TextStyle basicTextStyle() => GoogleFonts.aBeeZee(
        color: Constants.secondaryColor,
        fontSize: 14,
      );

  TextStyle errorTextStyle() => GoogleFonts.aBeeZee(
        color: Constants.secondaryColor,
        fontSize: 14,
      );

  TextFormField emailField() => TextFormField(
        style: basicTextStyle(),
        validator: (value) => value?.isEmpty == true ? _emailText : null,
        onChanged: (value) => setState(() => _email = value),
      );

  TextFormField passwordField() => TextFormField(
        style: basicTextStyle(),
        obscureText: true,
        validator: (value) =>
            (value?.length != null && value!.length < 6) ? _passwordText : null,
        onChanged: (value) => setState(() => _password = value),
      );

  ElevatedButton validateButton() => ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState?.validate() == true) {
            dynamic result = await AuthService.signInWithEmailAndPassword(
              _email,
              _password,
            );
            setState(() => result == null ? _error = _invalidCredentials : '');
          } else {
            setState(() => _error = '');
          }
        },
        child: const Text(_signIn),
        style: ElevatedButton.styleFrom(
          primary: Constants.secondaryColor,
          textStyle: const TextStyle(color: Colors.white),
        ),
      );

  Text emailErrorText() => Text(
        _error,
        style: errorTextStyle(),
      );

  // functions
  void _onMenuItemSelected(String value) async {
    switch (value) {
      case _register:
        widget._toggleView();
        break;
    }
  }
}
