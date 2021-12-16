import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messages/model/user.dart';
import 'package:messages/screen/home_wrapper.dart';
import 'package:messages/service/auth_service.dart';
import 'package:messages/shared/styles.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
// constructor
  const MyApp({Key? key}) : super(key: key);

// overrides
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // todo: implement a SomethingWentWrong widget
          return Center(
            child: Text(
              "Oops... something went terribly wrong!",
              style: Styles.basicTextStyle().copyWith(fontSize: 24),
              textDirection: TextDirection.ltr,
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<User?>.value(
            value: AuthService.user,
            initialData: null,
            child: const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: HomeWrapper(),
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
