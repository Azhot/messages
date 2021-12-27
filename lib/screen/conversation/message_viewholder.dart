import 'package:messages/model/user.dart';
import 'package:messages/shared/constants.dart';
import 'package:messages/model/message.dart';
import 'package:flutter/material.dart';
import 'package:messages/shared/styles.dart';

class MessageViewholder extends StatelessWidget {
  // variables
  final Message message;
  final Color titleColor;
  final Color messageBackgroundColor;
  final Alignment alignment;

  //constructors
  const MessageViewholder._fromUser(
    this.message, {
    Key? key,
  })  : titleColor = Constants.secondaryColor,
        messageBackgroundColor = Constants.primaryColor,
        alignment = Alignment.centerRight,
        super(key: key);

  const MessageViewholder._fromOther(
    this.message, {
    Key? key,
  })  : titleColor = Constants.primaryDarkColor,
        messageBackgroundColor = Constants.primaryLightColor,
        alignment = Alignment.centerLeft,
        super(key: key);

  // static functions
  static List<MessageViewholder> toMessageViewholders(
          List<Message> messages, User? author) =>
      messages
          .map((message) => message.author == author
              ? MessageViewholder._fromUser(message)
              : MessageViewholder._fromOther(message))
          .toList();

  // overrides
  @override
  Widget build(BuildContext context) => Container(
        alignment: alignment,
        child: Container(
          width: MediaQuery.of(context).size.width * 4 / 5,
          decoration: BoxDecoration(
            color: messageBackgroundColor,
            borderRadius: const BorderRadius.all(Radius.elliptical(8, 16)),
            boxShadow: const [
              BoxShadow(
                color: Constants.primaryColor,
                blurRadius: 4,
              ),
            ],
          ),
          margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.author.name,
                style: Styles.basicTextStyle(
                    color: titleColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                message.text,
                style: Styles.basicTextStyle(
                  color: Constants.messageTextColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      );
}
