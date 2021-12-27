import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:messages/model/user.dart';

@injectable
class UpdateUserData {
  // variables
  final FirebaseFirestore _firebaseFirestore;

  // constructors
  UpdateUserData(this._firebaseFirestore);

  // functions
  Future<bool> execute({
    required String uid,
    required String email,
    required String name,
  }) async {
    try {
      await _firebaseFirestore.collection(User.usersCollection).doc(uid).set({
        User.emailField: email,
        User.nameField: name,
      });
      return true;
    } catch (e) {
      log('Could not create or update user in firestore database', error: e);
      return false;
    }
  }
}
