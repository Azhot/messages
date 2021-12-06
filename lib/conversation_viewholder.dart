import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messages/shared/constants.dart';
import 'package:messages/conversation_page.dart';
import 'package:messages/model/conversation.dart';

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
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ConversationPage(
              conversation,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              conversation.title,
              style: GoogleFonts.aBeeZee(
                color: Constants.secondaryColor,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              conversation.messages.last.text,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: GoogleFonts.aBeeZee(
                color: Constants.messageTextColor,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
