import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messages/dependency_injection/injection.dart';
import 'package:messages/dependency_injection/use_case/observe_auth_state_changes.dart';
import 'package:messages/model/user.dart';
import 'package:messages/screen/home_wrapper.dart';
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
        theme: Styles.appTheme(),
        home: home,
      );

  StreamProvider<User?> userStreamProvider(Widget home) =>
      StreamProvider<User?>.value(
        value: inject<ObserveAuthStateChanges>().execute(),
        initialData: null,
        child: materialApp(home),
      );
}
