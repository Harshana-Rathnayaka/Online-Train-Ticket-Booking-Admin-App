import 'package:cloud_firestore/cloud_firestore.dart';

class RevenueService {
  Firestore _firestore = Firestore.instance;
  String ref = "revenue"; // collection name

  //  =============     RETRIEVING THE DATA TO DISPLAY    ==================
// this method retrieves the collection from the db
  Future<List<DocumentSnapshot>> getRevenue() =>
      _firestore.collection(ref).getDocuments().then((snaps) {
        return snaps.documents;
      });
}
