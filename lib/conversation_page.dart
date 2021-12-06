import 'package:messages/app_bar.dart';
import 'package:messages/message_viewholder.dart';
import 'package:messages/model/conversation.dart';
import 'package:flutter/material.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage(this.conversation, {Key? key}) : super(key: key);

  final Conversation conversation;

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MessagesAppBar(widget.conversation.title),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: Column(
            children: widget.conversation.messages
                .asMap()
                .map((i, message) => MapEntry(
                    i,
                    MessageViewholder(
                      message,
                      i % 2 == 0 ? Colors.green.shade50 : Colors.indigo.shade50,
                    )))
                .values
                .toList()),
      ),
    );
  }
}
