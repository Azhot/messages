import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messages/dependency_injection/injection.dart';
import 'package:messages/dependency_injection/use_case/add_message_to_conversation.dart';
import 'package:messages/dependency_injection/use_case/delete_conversation.dart';
import 'package:messages/dependency_injection/use_case/get_messages.dart';
import 'package:messages/model/message.dart';
import 'package:messages/model/user.dart';
import 'package:messages/screen/conversation/message_viewholder.dart';
import 'package:messages/shared/widget/app_bar.dart';
import 'package:messages/model/conversation.dart';
import 'package:flutter/material.dart';
import 'package:messages/shared/strings.dart';
import 'package:messages/shared/widget/loading.dart';
import 'package:messages/shared/widget/send_text_field.dart';
import 'package:messages/shared/widget/something_went_wrong.dart';
import 'package:provider/provider.dart';

class ConversationPage extends StatelessWidget {
  // variables
  final Conversation conversation;
  final ScrollController _controller = ScrollController();

  // constructors
  ConversationPage(this.conversation, {Key? key}) : super(key: key);

  // overrides
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: appBar(context),
        body: messagesStreamBuilder(context),
      );

  // widgets
  PreferredSizeWidget appBar(BuildContext context) => MessageAppBar(
        title: conversation.title,
        centerTitle: false,
        menuItems: {
          Strings.deleteConversation: () => {
                inject<DeleteConversation>()
                    .execute(conversation: conversation),
                Navigator.of(context).pop()
              },
        },
      );

  Widget messagesStreamBuilder(BuildContext context) =>
      StreamBuilder<QuerySnapshot>(
          stream: inject<GetMessages>().execute(conversation: conversation),
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Loading()
                  : (snapshot.hasError || snapshot.data == null)
                      ? const SomethingWentWrong()
                      : body(context, snapshot.data!));

  Widget body(BuildContext context, QuerySnapshot snapshot) => Column(
        children: [
          listMessages(context, snapshot),
          sendMessage(context),
        ],
      );

  Widget listMessages(BuildContext context, QuerySnapshot snapshot) {
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
            currentUserId: Provider.of<User>(context).uid),
      ),
    );
  }

  Widget sendMessage(BuildContext context) => SendTextField(
        hintText: Strings.writeAMessage,
        maxLines: 5,
        onSend: (String text) => {
          inject<AddMessageToConversation>().execute(
              conversationId: conversation.uid,
              authorId: Provider.of<User>(context, listen: false).uid,
              text: text),
        },
      );
}
