import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:messages/model/user.dart';

class AuthService {
  static final firebase.FirebaseAuth _firebaseAuth =
      firebase.FirebaseAuth.instance;

  static User? _userFromFirebaseUser(firebase.User? user) =>
      user != null ? User(user.uid) : null;

  static Stream<User?> get user =>
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
      String email, String password) async {
    try {
      firebase.UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return _userFromFirebaseUser(result.user);
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
