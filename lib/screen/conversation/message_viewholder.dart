import 'package:messages/dependency_injection/injection.dart';
import 'package:messages/dependency_injection/use_case/get_user_name.dart';
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

  // constructors
  const MessageViewholder._fromCurrentUser(
    this.message, {
    Key? key,
  })  : titleColor = Constants.secondaryColor,
        messageBackgroundColor = Constants.primaryColor,
        alignment = Alignment.centerRight,
        super(key: key);

  const MessageViewholder._fromOther(
    this.message, {
    Key? key,
  })  : titleColor = Constants.primaryColorDark,
        messageBackgroundColor = Constants.primaryColorLight,
        alignment = Alignment.centerLeft,
        super(key: key);

  // static functions
  static List<MessageViewholder> toMessageViewholders({
    required List<Message> messages,
    required String currentUserId,
  }) =>
      messages
          .map((message) => message.authorId == currentUserId
              ? MessageViewholder._fromCurrentUser(message)
              : MessageViewholder._fromOther(message))
          .toList();

  // overrides
  @override
  Widget build(BuildContext context) => Container(
        alignment: alignment,
        child: Container(
          width: MediaQuery.of(context).size.width * 4 / 5,
          decoration: messageBoxDecoration(),
          margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              messageAuthorName(),
              const SizedBox(height: 4),
              messageText(),
            ],
          ),
        ),
      );

  // functions
  BoxDecoration messageBoxDecoration() => BoxDecoration(
        color: messageBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.elliptical(8, 16)),
        boxShadow: const [
          BoxShadow(
            color: Constants.primaryColor,
            blurRadius: 4,
          ),
        ],
      );

  Widget messageAuthorName() => FutureBuilder<String>(
      future: inject<GetUserName>().execute(userId: message.authorId),
      builder: (context, snapshot) => Text(
            snapshot.data ?? '',
            style: Styles.basicTextStyle(
              color: titleColor,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ));

  Text messageText() => Text(
        message.text,
        style: Styles.basicTextStyle(
          color: Constants.messageTextColor,
          fontSize: 14,
        ),
      );
}
