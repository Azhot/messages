import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messages/dependency_injection/injection.dart';
import 'package:messages/model/conversation.dart';
import 'package:messages/model/user.dart';
import 'package:messages/screen/conversation_list/conversation_viewholder.dart';
import 'package:messages/shared/styles.dart';
import 'package:messages/shared/widget/app_bar.dart';
import 'package:messages/service/dummy_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:messages/shared/constants.dart';
import 'package:messages/shared/widget/loading.dart';
import 'package:messages/shared/widget/something_went_wrong.dart';
import 'package:messages/shared/strings.dart';
import 'package:messages/dependency_injection/use_case/sign_out.dart';

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
  MessageAppBar appBar() => MessageAppBar(
        Strings.homePageTitle,
        {
          Strings.signOut: inject<SignOut>().execute,
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
            builder: (context) => modalBottomSheet(context),
          )
        },
      );

  Widget modalBottomSheet(BuildContext context) => Column(
        children: [
          conversationTitle(),
          Expanded(child: usersStreamBuilder(context)),
        ],
      );

  Widget conversationTitle() => Theme(
        data: ThemeData().copyWith(
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ThemeData()
              .colorScheme
              .copyWith(primary: Constants.secondaryLightColor),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Constants.primaryLightColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset.fromDirection(-1, 0),
              ),
            ],
          ),
          child: TextField(
            style: Styles.basicTextStyle(),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(16),
              hintText: Strings.newConversationTitle,
              hintStyle: Styles.hintTextStyle(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => {},
              ),
            ),
          ),
        ),
      );

  StreamBuilder<QuerySnapshot> usersStreamBuilder(BuildContext context) =>
      StreamBuilder<QuerySnapshot>(
        stream: inject<FirebaseFirestore>()
            .collection(User.usersCollection)
            .snapshots(),
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
