import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messages/dependency_injection/injection.dart';
import 'package:messages/dependency_injection/use_case/get_conversations.dart';
import 'package:messages/dependency_injection/use_case/sign_out.dart';
import 'package:messages/model/conversation.dart';
import 'package:messages/screen/conversation_list/conversation_viewholder.dart';
import 'package:messages/screen/conversation_list/modal_bottom_sheet.dart';
import 'package:messages/shared/strings.dart';
import 'package:messages/shared/widget/app_bar.dart';
import 'package:messages/shared/widget/loading.dart';
import 'package:messages/shared/widget/something_went_wrong.dart';

class ConversationListPage extends StatelessWidget {
  // constructor
  const ConversationListPage({Key? key}) : super(key: key);

  // overrides
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: appBar(),
        body: conversationList(context),
        floatingActionButton: floatingActionButton(context),
      );

  // functions
  MessageAppBar appBar() => MessageAppBar(
        title: Strings.homePageTitle,
        menuItems: {
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
            builder: (context) => const ModalBottomSheet(),
          )
        },
      );
}
