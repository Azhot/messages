import 'package:flutter/material.dart';
import 'package:messages/dependency_injection/injection.dart';
import 'package:messages/shared/widget/app_bar.dart';
import 'package:messages/shared/widget/loading.dart';
import 'package:messages/shared/strings.dart';
import 'package:messages/shared/styles.dart';
import 'package:messages/dependency_injection/use_case/sign_in.dart';

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
        title: Strings.signInPageTitle,
        menuItems: {Strings.register: widget._toggleView},
      );

  Widget body() => Container(
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
            if (await inject<SignIn>().execute(
                  email: _email,
                  password: _password,
                ) ==
                null) {
              setState(() {
                _error = Strings.errorInvalidCredentials;
                _isLoading = false;
              });
            }
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
