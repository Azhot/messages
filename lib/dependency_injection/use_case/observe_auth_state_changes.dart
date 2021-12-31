import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:injectable/injectable.dart';
import 'package:messages/model/user.dart';

@injectable
class ObserveAuthStateChanges {
  // variables
  final FirebaseAuth _firebaseAuth;

  // constructor
  ObserveAuthStateChanges(this._firebaseAuth);

  // functions
  Stream<User?> execute() => _firebaseAuth
      .authStateChanges()
      .map((user) => user != null ? User.fromAuthUser(user) : null);
}
