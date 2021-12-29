import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:messages/model/user.dart';

@injectable
class GetUsers {
  // variables
  final FirebaseFirestore _firebaseFirestore;

  // constructors
  GetUsers(this._firebaseFirestore);

  // functions
  Stream<QuerySnapshot> execute() =>
      _firebaseFirestore.collection(User.usersCollection).snapshots();
}
