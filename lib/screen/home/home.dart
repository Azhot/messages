import 'package:messages/app_bar.dart';
import 'package:messages/constants.dart';
import 'package:messages/conversation_viewholder.dart';
import 'package:messages/dummy_data_provider.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MessagesAppBar(Constants.homePageTitle),
      body: SingleChildScrollView(
        child: Column(
            children: DummyDataProvider.provideDummyConversation()
                .asMap()
                .map(
                  (i, conversation) =>
                      MapEntry(i, ConversationViewholder(conversation)),
                )
                .values
                .toList()),
      ),
    );
  }

  void onMenuItemSelected(String value) {
    switch (value) {
      case 'Logout':
        break;
      case 'Settings':
        break;
    }
  }
}
