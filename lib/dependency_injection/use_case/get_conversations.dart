import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:messages/model/conversation.dart';

@injectable
class GetConversations {
  // variables
  final FirebaseFirestore _firebaseFirestore;

  // constructors
  GetConversations(this._firebaseFirestore);

  // functions
  Stream<QuerySnapshot> execute() => _firebaseFirestore
      .collection(Conversation.conversationsCollection)
      .orderBy(Conversation.lastUpdateField, descending: true)
      .snapshots();
}
