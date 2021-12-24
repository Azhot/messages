import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messages/model/conversation.dart';
import 'package:messages/model/user.dart';
import 'package:messages/screen/conversation_list/conversation_viewholder.dart';
import 'package:messages/service/database_service.dart';
import 'package:messages/shared/app_bar.dart';
import 'package:messages/service/dummy_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:messages/service/auth_service.dart';
import 'package:messages/shared/constants.dart';
import 'package:messages/shared/loading.dart';
import 'package:messages/shared/something_went_wrong.dart';
import 'package:messages/shared/strings.dart';

class ConversationListPage extends StatelessWidget {
// constructor
  const ConversationListPage({Key? key}) : super(key: key);

// overrides
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: appBar(),
        body: conversationList(),
        floatingActionButton: floatingActionButton(context),
      );

// private functions
  MessageAppBar appBar() => const MessageAppBar(
        Strings.homePageTitle,
        {
          Strings.signOut: AuthService.signOut,
          Strings.settings: null,
        },
      );

  SingleChildScrollView conversationList() {
    return SingleChildScrollView(
      child: Column(
        children: toConversationViewHolders(
            DummyDataProvider.provideDummyConversation()),
      ),
    );
  }

  List<ConversationViewholder> toConversationViewHolders(
    List<Conversation> conversations,
  ) =>
      conversations
          .map((conversation) => ConversationViewholder(conversation))
          .toList();

  FloatingActionButton floatingActionButton(BuildContext context) =>
      FloatingActionButton(
        child: const Icon(Icons.add_comment),
        onPressed: () => {
          showModalBottomSheet(
            context: context,
            builder: (context) => usersStreamBuilder(context),
          )
        },
      );

  StreamBuilder<QuerySnapshot> usersStreamBuilder(BuildContext context) =>
      StreamBuilder<QuerySnapshot>(
        stream: DatabaseService.users,
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Loading()
                : snapshot.hasError
                    ? const SomethingWentWrong()
                    : snapshot.data != null
                        ? usersListView(snapshot.data!.docs)
                        : const SomethingWentWrong(),
      );

  Widget usersListView(List<QueryDocumentSnapshot> docs) => Material(
      color: Constants.primaryLightColor,
      child: ListView(children: docs.map((doc) => userTile(doc)).toList()));

  ListTile userTile(QueryDocumentSnapshot doc) => ListTile(
        leading: const SizedBox(
            height: double.infinity,
            child: Icon(
              Icons.person_add,
              color: Constants.secondaryLightColor,
              size: 32,
            )),
        title: Text(doc[User.nameField]),
        subtitle: Text(doc[User.emailField]),
        onTap: () => {},
      );
}
