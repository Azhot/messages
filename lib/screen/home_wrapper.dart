import 'package:flutter/material.dart';
import 'package:messages/model/user.dart';
import 'package:messages/screen/authenticate/authenticate_wrapper.dart';
import 'package:messages/screen/conversation_list/conversation_list_page.dart';
import 'package:provider/provider.dart';

class HomeWrapper extends StatelessWidget {
  const HomeWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return (user is User)
        ? ConversationListPage()
        : const AuthenticateWrapper();
  }
}
