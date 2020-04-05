import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
   Firestore _firestore = Firestore.instance; // db instance
  String ref = "users"; // collection name
  String activeUsersCount = "0"; // to store the user count

  //   ================ DOCUMENT COUNT TO DISPLAY ON THE DASHBOARD   ====================
  // this method gets  the user count
  Future<List<DocumentSnapshot>> getUserCount() {
    _firestore.collection(ref).getDocuments().then((snaps) {
      activeUsersCount = snaps.documents.length.toString();
    });

    return null;
  }
}
