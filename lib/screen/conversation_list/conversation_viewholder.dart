import 'package:flutter/material.dart';
import 'package:messages/dependency_injection/injection.dart';
import 'package:messages/dependency_injection/use_case/get_conversation_subtitle.dart';
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
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Constants.primaryColorLight),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title(),
            const SizedBox(height: 4),
            subtitle(),
          ],
        ),
      );

  Widget title() => Text(
        conversation.title,
        style: Styles.basicTextStyle(
            color: Constants.primaryColorDark,
            fontWeight: FontWeight.w500,
            fontSize: 16),
      );

  Widget subtitle() => FutureBuilder<String?>(
        future: inject<GetConversationSubtitle>()
            .execute(conversation: conversation),
        builder: (context, snapshot) => Text(
          snapshot.data ?? '',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: Styles.hintTextStyle(),
        ),
      );

  // functions
  void navigateToConversationPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ConversationPage(conversation)),
    );
  }
}
