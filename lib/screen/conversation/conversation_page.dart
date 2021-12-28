import 'package:messages/model/user.dart';
import 'package:messages/shared/widget/app_bar.dart';
import 'package:messages/screen/conversation/message_viewholder.dart';
import 'package:messages/model/conversation.dart';
import 'package:flutter/material.dart';
import 'package:messages/shared/constants.dart';
import 'package:messages/shared/strings.dart';
import 'package:messages/shared/styles.dart';
import 'package:provider/provider.dart';

class ConversationPage extends StatelessWidget {
  // variables
  final Conversation conversation;

  // constructors
  const ConversationPage(this.conversation, {Key? key}) : super(key: key);

  // overrides
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: appBar(),
        body: listMessage(context),
        bottomSheet: newMessage(),
      );

  // widgets
  PreferredSizeWidget appBar() => MessageAppBar(
        conversation.author.name,
        const {
          Strings.settings: null,
        },
      );

  Widget listMessage(BuildContext context) => SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Column(
        children: MessageViewholder.toMessageViewholders(
            conversation.messages, Provider.of<User>(context)),
      ));

  Widget newMessage() => Theme(
        data: ThemeData().copyWith(
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ThemeData()
              .colorScheme
              .copyWith(primary: Constants.secondaryLightColor),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Constants.primaryLightColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset.fromDirection(-1, 0),
              ),
            ],
          ),
          child: TextField(
            maxLines: 5,
            minLines: 1,
            style: Styles.basicTextStyle(),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
              hintText: Strings.writeAMessage,
              hintStyle: Styles.hintTextStyle(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => {},
              ),
            ),
          ),
        ),
      );
}
