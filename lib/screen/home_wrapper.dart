import 'package:flutter/material.dart';
import 'package:messages/model/user.dart';
import 'package:messages/screen/authenticate/authenticate.dart';
import 'package:messages/screen/home/home.dart';
import 'package:provider/provider.dart';

class HomeWrapper extends StatelessWidget {
  const HomeWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return (user is User) ? const Home() : const Authenticate();
  }
}
