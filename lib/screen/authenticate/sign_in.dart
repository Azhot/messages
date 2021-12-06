import 'package:flutter/material.dart';
import 'package:messages/shared/constants.dart';
import 'package:messages/service/auth_service.dart';
import 'package:messages/shared/strings.dart';
import 'package:messages/shared/styles.dart';

class SignIn extends StatefulWidget {
  // variables
  final Function _toggleView;

  const SignIn(this._toggleView, {Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
          Strings.signInPageTitle,
          style: Styles.appBarTextStyle(),
        ),
        backgroundColor: Constants.primaryColor,
        actions: menu(),
      );

  List<Widget> menu() => [
        PopupMenuButton(
            onSelected: _onMenuItemSelected,
            itemBuilder: (BuildContext context) {
              return {Strings.register}
                  .map((String choice) => PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      ))
                  .toList();
            })
      ];

  Container body() {
    return Container(
      color: Colors.white,
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

  TextFormField emailField() => TextFormField(
        style: Styles.basicTextStyle(),
        decoration: Styles.textInputDecoration(Strings.email),
        validator: (value) =>
            value?.isEmpty == true ? Strings.errorMissingEmail : null,
        onChanged: (value) => setState(() => _email = value),
      );

  TextFormField passwordField() => TextFormField(
        style: Styles.basicTextStyle(),
        decoration: Styles.textInputDecoration(Strings.password),
        obscureText: true,
        validator: (value) => (value?.length != null && value!.length < 6)
            ? Strings.errorInvalidPassword
            : null,
        onChanged: (value) => setState(() => _password = value),
      );

  ElevatedButton validateButton() => ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState?.validate() == true) {
            dynamic result = await AuthService.signInWithEmailAndPassword(
              _email,
              _password,
            );
            setState(() =>
                result == null ? _error = Strings.errorInvalidCredentials : '');
          } else {
            setState(() => _error = '');
          }
        },
        child: const Text(Strings.signIn),
        style: Styles.basicButtonStyle(),
      );

  Text emailErrorText() => Text(
        _error,
        style: Styles.errorTextStyle(),
      );

  // functions
  void _onMenuItemSelected(String value) async {
    switch (value) {
      case Strings.register:
        widget._toggleView();
        break;
    }
  }
}
