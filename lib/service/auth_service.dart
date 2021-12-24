import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:messages/model/user.dart';
import 'package:messages/service/database_service.dart';

class AuthService {
  static final firebase.FirebaseAuth _firebaseAuth =
      firebase.FirebaseAuth.instance;

  static User? _userFromFirebaseUser(firebase.User? user) => user != null
      ? User(
          uid: user.uid,
          email: user.email ?? '',
          name: user.displayName ?? '',
        )
      : null;

  static Stream<User?> get currentUser =>
      _firebaseAuth.authStateChanges().map(_userFromFirebaseUser);

  static Future<User?> signInAnonymously() async {
    try {
      firebase.UserCredential result = await _firebaseAuth.signInAnonymously();
      return _userFromFirebaseUser(result.user);
    } catch (e) {
      log("Authentication failed!", error: e);
      return null;
    }
  }

  static Future<User?> registerWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      firebase.UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (result.user != null) {
        log('result.user != null');
        await result.user?.updateDisplayName(name);
        await DatabaseService.updateUserData(result.user!.uid, email, name);
      }

      return _userFromFirebaseUser(_firebaseAuth.currentUser);
    } catch (e) {
      log("Registering failed!", error: e);
      return null;
    }
  }

  static Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      firebase.UserCredential result = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebaseUser(result.user);
    } catch (e) {
      log("Registering failed!", error: e);
      return null;
    }
  }

  static Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      log("Sign out failed!", error: e);
      return null;
    }
  }
}
