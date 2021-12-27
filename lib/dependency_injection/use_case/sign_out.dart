import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignOut {
  // variables
  final FirebaseAuth _firebaseAuth;

  // constructor
  SignOut(this._firebaseAuth);

  // functions
  Future execute() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      log("Sign out failed", error: e);
      return null;
    }
  }
}
