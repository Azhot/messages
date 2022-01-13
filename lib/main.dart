import 'package:flutter/material.dart';
import 'package:messages/dependency_injection/injection.dart';
import 'package:messages/my_app.dart';
import 'package:messages/shared/styles.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Styles.setSystemOverlayStyle();
  await configureDependencyInjection();
  runApp(const MyApp());
}
