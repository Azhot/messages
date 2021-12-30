import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:messages/model/conversation.dart';
import 'package:messages/model/message.dart';
import 'package:messages/model/user.dart';

@injectable
class GetConversationSubtitle {
  // variables
  final FirebaseFirestore _firebaseFirestore;

  // constructors
  GetConversationSubtitle(this._firebaseFirestore);

  // functions
  Future<String> execute(Conversation conversation) async => _firebaseFirestore
      .collection(Conversation.conversationsCollection)
      .doc(conversation.uid)
      .collection(Message.messagesCollection)
      .orderBy(Message.timeStampField, descending: true)
      .limit(1)
      .get()
      .then((messageDoc) => _firebaseFirestore
          .collection(User.usersCollection)
          .doc(messageDoc.docs.first[Message.authorIdField])
          .get()
          .then((userDoc) =>
              '${userDoc[User.nameField]}: ${messageDoc.docs.first[Message.textField]}'));
}
