import 'package:cloud_firestore/cloud_firestore.dart';

class BookingService {
   Firestore _firestore = Firestore.instance; // db instance
  String ref = "reservations"; // collection name
  String reservationsCount = "0"; // to store the reservations count

  //   ================ DOCUMENT COUNT TO DISPLAY ON THE DASHBOARD   ====================
  // this method gets  the reservations count
  Future<List<DocumentSnapshot>> getReservationCount() {
    _firestore.collection(ref).getDocuments().then((snaps) {
      reservationsCount = snaps.documents.length.toString();
    });

    return null;
  }
}
