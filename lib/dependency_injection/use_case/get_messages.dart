import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:messages/model/conversation.dart';
import 'package:messages/model/message.dart';

@injectable
class GetMessages {
  // variables
  final FirebaseFirestore _firebaseFirestore;

  // constructors
  GetMessages(this._firebaseFirestore);

  // functions
  Stream<QuerySnapshot> execute({required Conversation conversation}) =>
      _firebaseFirestore
          .collection(Conversation.conversationsCollection)
          .doc(conversation.uid)
          .collection(Message.messagesCollection)
          .orderBy(Message.timeStampField)
          .snapshots();
}
