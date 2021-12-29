import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:messages/model/conversation.dart';
import 'package:messages/model/message.dart';

@injectable
class AddMessageToConversation {
  // variables
  final FirebaseFirestore _firebaseFirestore;

  // constructors
  AddMessageToConversation(this._firebaseFirestore);

  // functions
  Future<bool> execute({
    required String conversationId,
    required String authorId,
    required int date,
    required String text,
  }) async {
    try {
      var doc = _firebaseFirestore
          .collection(Conversation.conversationsCollection)
          .doc(conversationId);

      await doc.collection(Message.messagesCollection).add({
        Message.authorIdField: authorId,
        Message.dateField: date,
        Message.textField: text,
      });

      await doc.update({Conversation.lastUpdateField: date});

      return true;
    } catch (e) {
      log('Could not add message to conversation with id: $conversationId',
          error: e);
      return false;
    }
  }
}
