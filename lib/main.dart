import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messages/dependency_injection/injection.dart';
import 'package:messages/model/user.dart';
import 'package:messages/screen/home_wrapper.dart';
import 'package:messages/shared/constants.dart';
import 'package:messages/shared/styles.dart';
import 'package:messages/shared/widget/loading.dart';
import 'package:messages/shared/widget/something_went_wrong.dart';
import 'package:provider/provider.dart';

Future main() async {
  Styles.setSystemOverlayStyle();
  configureDependencyInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
// constructor
  const MyApp({Key? key}) : super(key: key);

// overrides
  @override
  Widget build(BuildContext context) => futureAppBuilder();

  // functions
  FutureBuilder futureAppBuilder() => FutureBuilder(
        future: Firebase.initializeApp(),
        builder: appBuilder(),
      );

  AsyncWidgetBuilder appBuilder() =>
      (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
          ? materialApp(const Loading())
          : snapshot.hasError
              ? materialApp(const SomethingWentWrong())
              : userStreamProvider(const HomeWrapper());

  MaterialApp materialApp(Widget home) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        home: home,
      );

  ThemeData appTheme() => ThemeData().copyWith(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Constants.primaryColor,
              secondary: Constants.secondaryColor,
              primaryVariant: Constants.primaryLightColor,
              secondaryVariant: Constants.secondaryLightColor,
            ),
      );

  StreamProvider<User?> userStreamProvider(Widget home) =>
      StreamProvider<User?>.value(
        value: inject<auth.FirebaseAuth>()
            .authStateChanges()
            .map((user) => User.fromAuthUser(user)),
        initialData: null,
        child: materialApp(home),
      );
}
