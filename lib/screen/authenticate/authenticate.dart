import 'package:flutter/material.dart';
import 'package:messages/screen/authenticate/register.dart';
import 'package:messages/screen/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  // state variables
  bool showSignIn = true;

  // private functions
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn ? SignIn(toggleView) : Register(toggleView);
  }
}
