import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messages/dependency_injection/injection.dart';
import 'package:messages/dependency_injection/use_case/create_conversation.dart';
import 'package:messages/dependency_injection/use_case/get_users.dart';
import 'package:messages/model/user.dart';
import 'package:messages/shared/constants.dart';
import 'package:messages/shared/strings.dart';
import 'package:messages/shared/widget/loading.dart';
import 'package:messages/shared/widget/send_text_field.dart';
import 'package:messages/shared/widget/something_went_wrong.dart';

class ModalBottomSheet extends StatelessWidget {
  // constructors
  const ModalBottomSheet({Key? key}) : super(key: key);

  // overrides
  @override
  Widget build(BuildContext context) => Column(
        children: [
          conversationTitleField(context),
          Expanded(child: usersStreamBuilder(context)),
        ],
      );

  // functions
  Widget conversationTitleField(BuildContext context) => SendTextField(
        hintText: Strings.newConversationTitle,
        maxLines: 1,
        onSend: (String text) => {
          inject<CreateConversation>().execute(title: text),
          Navigator.pop(context)
        },
      );

  StreamBuilder<QuerySnapshot> usersStreamBuilder(BuildContext context) =>
      StreamBuilder<QuerySnapshot>(
        stream: inject<GetUsers>().execute(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Loading()
                : snapshot.hasError
                    ? const SomethingWentWrong()
                    : snapshot.data != null
                        ? usersListView(snapshot.data!.docs)
                        : const SomethingWentWrong(),
      );

  Widget usersListView(List<QueryDocumentSnapshot> docs) => Material(
      color: Constants.primaryColorLight,
      child: ListView(children: docs.map((doc) => userTile(doc)).toList()));

  ListTile userTile(QueryDocumentSnapshot doc) => ListTile(
        leading: const SizedBox(
            height: double.infinity,
            child: Icon(
              Icons.person_add,
              color: Constants.secondaryColorLight,
              size: 32,
            )),
        title: Text(doc[User.nameField]),
        subtitle: Text(doc[User.emailField]),
        onTap: () => {},
      );
}
