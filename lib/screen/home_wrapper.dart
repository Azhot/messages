import 'package:flutter/material.dart';
import 'package:messages/model/user.dart';
import 'package:messages/screen/authenticate/authenticate_wrapper.dart';
import 'package:messages/screen/conversation_list/conversation_list_page.dart';
import 'package:messages/shared/widget/loading.dart';
import 'package:provider/provider.dart';

class HomeWrapper extends StatelessWidget {
  // constructors
  const HomeWrapper({Key? key}) : super(key: key);

  // overrides
  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);
    return user != User.empty()
        ? user != null
            ? const ConversationListPage()
            : const AuthenticateWrapper()
        : const Loading();
  }
}
