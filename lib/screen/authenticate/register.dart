import 'package:flutter/material.dart';
import 'package:messages/shared/constants.dart';
import 'package:messages/service/auth_service.dart';
import 'package:messages/shared/strings.dart';
import 'package:messages/shared/styles.dart';

class Register extends StatefulWidget {
  // variables
  final Function _toggleView;

  const Register(this._toggleView, {Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
          Strings.registerPageTitle,
          style: Styles.appBarTextStyle(),
        ),
        backgroundColor: Constants.primaryColor,
        actions: menu(),
      );

  List<Widget> menu() => [
        PopupMenuButton(
            onSelected: _onMenuItemSelected,
            itemBuilder: (BuildContext context) {
              return {Strings.signIn}
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
            dynamic result = await AuthService.registerWithEmailAndPassword(
              _email,
              _password,
            );
            setState(
                () => result == null ? _error = Strings.errorInvalidEmail : '');
          } else {
            setState(() => _error = '');
          }
        },
        child: const Text(Strings.register),
        style: Styles.basicButtonStyle(),
      );

  Text emailErrorText() => Text(
        _error,
        style: Styles.errorTextStyle(),
      );

  // functions
  void _onMenuItemSelected(String value) async {
    switch (value) {
      case Strings.signIn:
        widget._toggleView();
        break;
    }
  }
}
