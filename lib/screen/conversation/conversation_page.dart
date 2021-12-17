import 'package:messages/model/message.dart';
import 'package:messages/shared/app_bar.dart';
import 'package:messages/screen/conversation/message_viewholder.dart';
import 'package:messages/model/conversation.dart';
import 'package:flutter/material.dart';
import 'package:messages/service/auth_service.dart';
import 'package:messages/shared/strings.dart';

class ConversationPage extends StatelessWidget {
  // variables
  final Conversation conversation;

  // constructors
  const ConversationPage(this.conversation, {Key? key}) : super(key: key);

  // overrides
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: appBar(),
        body: body(),
      );

  // widgets
  PreferredSizeWidget appBar() => MessageAppBar(
        conversation.title,
        const {
          Strings.signOut: AuthService.signOut,
          Strings.settings: null,
        },
      );

  Widget body() => SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Column(
        children: toMessageViewholders(conversation.messages),
      ));

  List<MessageViewholder> toMessageViewholders(List<Message> messages) =>
      messages
          .asMap()
          .map((i, message) => MapEntry(
              i,
              MessageViewholder(
                message,
                i % 2 == 0 ? Colors.green.shade50 : Colors.indigo.shade50,
              )))
          .values
          .toList();
}
