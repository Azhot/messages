import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:messages/model/user.dart';

@injectable
class GetUserName {
  // variables
  final FirebaseFirestore _firebaseFirestore;

  // constructors
  GetUserName(this._firebaseFirestore);

  // functions
  Future<String> execute({required String userId}) async =>
      await _firebaseFirestore
          .collection(User.usersCollection)
          .doc(userId)
          .get()
          .then((user) => user.get(User.nameField));
}
