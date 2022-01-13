import 'package:flutter/material.dart';
import 'package:messages/screen/authenticate/register_page.dart';
import 'package:messages/screen/authenticate/sign_in_page.dart';

class AuthenticateWrapper extends StatefulWidget {
  // constructors
  const AuthenticateWrapper({Key? key}) : super(key: key);

  // overrides
  @override
  _AuthenticateWrapperState createState() => _AuthenticateWrapperState();
}

class _AuthenticateWrapperState extends State<AuthenticateWrapper> {
  // state variables
  bool showSignIn = true;

  // overrides
  @override
  Widget build(BuildContext context) =>
      showSignIn ? SignInPage(toggleView) : RegisterPage(toggleView);

  // functions
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }
}
