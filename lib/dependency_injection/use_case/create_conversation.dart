import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:messages/model/conversation.dart';

@injectable
class CreateConversation {
  // variables
  final FirebaseFirestore _firebaseFirestore;

  // constructors
  CreateConversation(this._firebaseFirestore);

  // functions
  Future<bool> execute({required String title}) async {
    try {
      await _firebaseFirestore
          .collection(Conversation.conversationsCollection)
          .add({
        Conversation.titleField: title,
        Conversation.lastUpdateField: DateTime.now().millisecondsSinceEpoch,
      });
      return true;
    } catch (e) {
      log('Could not create collection in firestore database', error: e);
      return false;
    }
  }
}
