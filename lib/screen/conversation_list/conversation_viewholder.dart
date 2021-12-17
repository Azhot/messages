import 'package:flutter/material.dart';
import 'package:messages/shared/constants.dart';
import 'package:messages/screen/conversation/conversation_page.dart';
import 'package:messages/model/conversation.dart';
import 'package:messages/shared/styles.dart';

class ConversationViewholder extends StatelessWidget {
  // variables
  final Conversation conversation;

  // constructors
  const ConversationViewholder(
    this.conversation, {
    Key? key,
  }) : super(key: key);

  // overrides
  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => navigateToConversationPage(context),
        child: body(),
      );

  // widgets
  Widget body() => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleText(),
            const SizedBox(height: 4),
            messageText(),
          ],
        ),
      );

  Text titleText() => Text(
        conversation.title,
        style: Styles.basicTextStyle(
            color: Constants.secondaryColor,
            fontWeight: FontWeight.w800,
            fontSize: 16),
      );

  Text messageText() => Text(conversation.messages.last.text,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: Styles.basicTextStyle(fontWeight: FontWeight.w400));

  // functions
  void navigateToConversationPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ConversationPage(
          conversation,
        ),
      ),
    );
  }
}
