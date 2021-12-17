import 'package:flutter/material.dart';
import 'package:messages/shared/app_bar.dart';
import 'package:messages/service/auth_service.dart';
import 'package:messages/shared/loading.dart';
import 'package:messages/shared/strings.dart';
import 'package:messages/shared/styles.dart';

class SignInPage extends StatefulWidget {
  // variables
  final Function _toggleView;

  // constructors
  const SignInPage(this._toggleView, {Key? key}) : super(key: key);

  // overrides
  @override
  _SignInPageState createState() => _SignInPageState();
}

// state class
class _SignInPageState extends State<SignInPage> {
  // state variables
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
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
        Strings.signInPageTitle,
        {
          Strings.register: widget._toggleView,
        },
      );

  Widget body() => Container(
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
            setState(() => _isLoading = true);
            dynamic result = await AuthService.signInWithEmailAndPassword(
              _email,
              _password,
            );
            setState(() {
              result == null ? _error = Strings.errorInvalidCredentials : '';
              _isLoading = false;
            });
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
}
