import 'package:flutter/material.dart';
import 'package:messages/model/user.dart';
import 'package:messages/shared/app_bar.dart';
import 'package:messages/service/auth_service.dart';
import 'package:messages/shared/loading.dart';
import 'package:messages/shared/strings.dart';
import 'package:messages/shared/styles.dart';

class RegisterPage extends StatefulWidget {
  // variables
  final Function _toggleView;

  // constructors
  const RegisterPage(this._toggleView, {Key? key}) : super(key: key);

  // overrides
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

// state class
class _RegisterPageState extends State<RegisterPage> {
  // state variables
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';
  String _error = '';

  // overrides
  @override
  Widget build(BuildContext context) => _isLoading
      ? const Loading()
      : Scaffold(
          appBar: appBar(),
          body: body(),
        );

  // widgets
  PreferredSizeWidget appBar() => MessageAppBar(
        Strings.registerPageTitle,
        {
          Strings.signIn: widget._toggleView,
        },
      );

  Widget body() => Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              spacer(),
              nameField(),
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

  SizedBox spacer() => const SizedBox(height: 16);

  TextFormField nameField() => TextFormField(
        style: Styles.basicTextStyle(),
        decoration: Styles.textInputDecoration(Strings.name),
        validator: (value) => (value?.length != null && value!.length < 3)
            ? Strings.errorInvalidName
            : null,
        onChanged: (value) => setState(() => _name = value),
      );

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
            setState(() => _isLoading = true);
            User? user = await AuthService.registerWithEmailAndPassword(
              _name,
              _email,
              _password,
            );
            if (user == null) {
              setState(() {
                _error = Strings.errorInvalidEmail;
                _isLoading = false;
              });
            }
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
}
