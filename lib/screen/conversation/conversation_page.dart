import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:messages/dependency_injection/injection.dart';
import 'package:messages/dependency_injection/use_case/add_message_to_conversation.dart';
import 'package:messages/dependency_injection/use_case/get_messages.dart';
import 'package:messages/model/message.dart';
import 'package:messages/screen/conversation/message_viewholder.dart';
import 'package:messages/shared/widget/app_bar.dart';
import 'package:messages/model/conversation.dart';
import 'package:flutter/material.dart';
import 'package:messages/shared/strings.dart';
import 'package:messages/shared/widget/loading.dart';
import 'package:messages/shared/widget/send_text_field.dart';
import 'package:messages/shared/widget/something_went_wrong.dart';

class ConversationPage extends StatelessWidget {
  // variables
  final Conversation conversation;
  final ScrollController _controller = ScrollController();

  // constructors
  ConversationPage(this.conversation, {Key? key}) : super(key: key);

  // overrides
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: appBar(),
        body: messagesStreamBuilder(context),
      );

  // widgets
  PreferredSizeWidget appBar() => MessageAppBar(
        title: conversation.title,
        menuItems: const {Strings.settings: null},
      );

  Widget messagesStreamBuilder(BuildContext context) =>
      StreamBuilder<QuerySnapshot>(
          stream: inject<GetMessages>().execute(conversation: conversation),
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Loading()
                  : (snapshot.hasError || snapshot.data == null)
                      ? const SomethingWentWrong()
                      : body(snapshot.data!));

  Widget body(QuerySnapshot snapshot) => Column(
        children: [
          listMessages(snapshot),
          sendMessage(),
        ],
      );

  Widget listMessages(QuerySnapshot snapshot) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _controller.jumpTo(_controller.position.maxScrollExtent);
    });
    return Expanded(
      child: ListView(
        controller: _controller,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        children: MessageViewholder.toMessageViewholders(
            messages: snapshot.docs
                .map((doc) => Message.fromDocumentSnapshot(doc))
                .toList(),
            currentUserId: inject<auth.FirebaseAuth>().currentUser?.uid),
      ),
    );
  }

  Widget sendMessage() => SendTextField(
        hintText: Strings.writeAMessage,
        maxLines: 5,
        onSend: (String text) => {
          inject<AddMessageToConversation>().execute(
              conversationId: conversation.uid,
              authorId: auth.FirebaseAuth.instance.currentUser!.uid,
              text: text),
        },
      );
}
