import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:injectable/injectable.dart';
import 'package:messages/model/user.dart';

@injectable
class SignIn {
  // variables
  final auth.FirebaseAuth _firebaseAuth;

  // constructor
  SignIn(this._firebaseAuth);

  // functions
  Future<User?> execute(String email, String password) async {
    try {
      auth.UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.user != null
          ? User.fromAuthUser(credential.user!)
          : throw Exception();
    } catch (e) {
      log("Registering failed!", error: e);
      return null;
    }
  }
}
