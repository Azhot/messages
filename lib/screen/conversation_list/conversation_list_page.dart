import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messages/dependency_injection/injection.dart';
import 'package:messages/dependency_injection/use_case/create_conversation.dart';
import 'package:messages/dependency_injection/use_case/get_conversations.dart';
import 'package:messages/dependency_injection/use_case/get_users.dart';
import 'package:messages/model/conversation.dart';
import 'package:messages/model/user.dart';
import 'package:messages/screen/conversation_list/conversation_viewholder.dart';
import 'package:messages/shared/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:messages/shared/constants.dart';
import 'package:messages/shared/widget/loading.dart';
import 'package:messages/shared/widget/send_text_field.dart';
import 'package:messages/shared/widget/something_went_wrong.dart';
import 'package:messages/shared/strings.dart';
import 'package:messages/dependency_injection/use_case/sign_out.dart';

class ConversationListPage extends StatelessWidget {
// variables
  final TextEditingController controller = TextEditingController();

// constructor
  ConversationListPage({Key? key}) : super(key: key);

// overrides
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: appBar(),
        body: conversationList(context),
        floatingActionButton: floatingActionButton(context),
      );

// private functions
  MessageAppBar appBar() => MessageAppBar(
        Strings.homePageTitle,
        {
          Strings.signOut: inject<SignOut>().execute,
          Strings.settings: null,
        },
      );

  SingleChildScrollView conversationList(BuildContext context) {
    return SingleChildScrollView(
      child: conversationsStreamBuilder(context),
    );
  }

  StreamBuilder<QuerySnapshot> conversationsStreamBuilder(
          BuildContext context) =>
      StreamBuilder<QuerySnapshot>(
        stream: inject<GetConversations>().execute(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Loading()
            : snapshot.hasError
                ? const SomethingWentWrong()
                : snapshot.data != null
                    ? Column(
                        children: snapshot.data!.docs
                            .map((doc) => ConversationViewholder(Conversation(
                                uid: doc.id,
                                title: doc[Conversation.titleField],
                                lastUpdate: doc[Conversation.lastUpdateField])))
                            .toList(),
                      )
                    : const SomethingWentWrong(),
      );

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
            builder: (context) => ModalBottomSheet(controller),
          )
        },
      );
}

class ModalBottomSheet extends StatelessWidget {
  // variables
  final TextEditingController controller;

  // constructors
  const ModalBottomSheet(this.controller, {Key? key}) : super(key: key);

  // overrides
  @override
  Widget build(BuildContext context) => Column(
        children: [
          conversationTitleField(context),
          Expanded(child: usersStreamBuilder(context)),
        ],
      );

  // functions
  Widget conversationTitleField(BuildContext context) => SendTextField(
        hintText: Strings.newConversationTitle,
        maxLines: 1,
        onSend: (String text) => {
          inject<CreateConversation>().execute(title: text),
          Navigator.pop(context)
        },
      );

  StreamBuilder<QuerySnapshot> usersStreamBuilder(BuildContext context) =>
      StreamBuilder<QuerySnapshot>(
        stream: inject<GetUsers>().execute(),
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
      color: Constants.primaryColorLight,
      child: ListView(children: docs.map((doc) => userTile(doc)).toList()));

  ListTile userTile(QueryDocumentSnapshot doc) => ListTile(
        leading: const SizedBox(
            height: double.infinity,
            child: Icon(
              Icons.person_add,
              color: Constants.secondaryColorLight,
              size: 32,
            )),
        title: Text(doc[User.nameField]),
        subtitle: Text(doc[User.emailField]),
        onTap: () => {},
      );
}
