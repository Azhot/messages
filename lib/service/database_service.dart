import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference messageCollection =
      FirebaseFirestore.instance.collection('messages');
}
