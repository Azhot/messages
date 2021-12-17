import 'package:messages/model/conversation.dart';
import 'package:messages/screen/conversation_list/conversation_viewholder.dart';
import 'package:messages/shared/app_bar.dart';
import 'package:messages/service/dummy_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:messages/service/auth_service.dart';
import 'package:messages/shared/strings.dart';

class ConversationListPage extends StatelessWidget {
// constructor
  const ConversationListPage({Key? key}) : super(key: key);

// overrides
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: appBar(),
        body: body(),
      );

// private functions
  MessageAppBar appBar() => const MessageAppBar(
        Strings.homePageTitle,
        {
          Strings.signOut: AuthService.signOut,
          Strings.settings: null,
        },
      );

  SingleChildScrollView body() => SingleChildScrollView(
        child: Column(
          children: toConversationViewHolders(
              DummyDataProvider.provideDummyConversation()),
        ),
      );

  List<ConversationViewholder> toConversationViewHolders(
    List<Conversation> conversations,
  ) =>
      conversations
          .map((conversation) => ConversationViewholder(conversation))
          .toList();
}
