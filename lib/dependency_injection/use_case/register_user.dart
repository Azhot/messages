import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:injectable/injectable.dart';
import 'package:messages/dependency_injection/use_case/update_user_data.dart';

@injectable
class RegisterUser {
  // variables
  final FirebaseAuth _firebaseAuth;
  final UpdateUserData _updateUserDataUseCase;

  // constructor
  RegisterUser(this._firebaseAuth, this._updateUserDataUseCase);

  // functions
  Future<bool> execute({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (credential.user == null) throw Exception('credential.user is null');
      await credential.user!.updateDisplayName(name);
      return await _updateUserDataUseCase.execute(
        uid: credential.user!.uid,
        email: email,
        name: name,
      );
    } catch (e) {
      log("Could not register to firebase auth", error: e);
      return false;
    }
  }
}
