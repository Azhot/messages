import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:messages/model/conversation.dart';

@injectable
class DeleteConversation {
  // variables
  final FirebaseFirestore _firebaseFirestore;

  // constructors
  DeleteConversation(this._firebaseFirestore);

  // functions
  Future execute({required Conversation conversation}) async {
    try {
      return await _firebaseFirestore
          .collection(Conversation.conversationsCollection)
          .doc(conversation.uid)
          .delete();
    } catch (e) {
      log('Could not delete $conversation in firestore database', error: e);
      return null;
    }
  }
}
