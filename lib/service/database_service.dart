import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messages/model/user.dart';

class DatabaseService {
  // users collection
  static final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  static Stream<QuerySnapshot> get users => _usersCollection.snapshots();

  static Future updateUserData(String uid, String email, String name) async =>
      _usersCollection.doc(uid).set({
        User.emailField: email,
        User.nameField: name,
      });

  // conversations collection
  static final CollectionReference conversationsCollection =
      FirebaseFirestore.instance.collection('conversations');
}
