import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:injectable/injectable.dart';
import 'package:messages/model/user.dart';

@injectable
class SignIn {
  // variables
  final FirebaseAuth _firebaseAuth;

  // constructor
  SignIn(this._firebaseAuth);

  // functions
  Future<User?> execute({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await _firebaseAuth
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
