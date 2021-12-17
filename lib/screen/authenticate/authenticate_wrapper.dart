import 'package:flutter/material.dart';
import 'package:messages/screen/authenticate/register_page.dart';
import 'package:messages/screen/authenticate/sign_in_page.dart';

class AuthenticateWrapper extends StatefulWidget {
  const AuthenticateWrapper({Key? key}) : super(key: key);

  @override
  _AuthenticateWrapperState createState() => _AuthenticateWrapperState();
}

class _AuthenticateWrapperState extends State<AuthenticateWrapper> {
  // state variables
  bool showSignIn = true;

  // private functions
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn ? SignInPage(toggleView) : RegisterPage(toggleView);
  }
}
