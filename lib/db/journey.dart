import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class JourneyService {
  Firestore _firestore = Firestore.instance; // db instance
  String ref = "journeys"; // collection name
  String journeyCount = "0"; // to store the journey count

// =================      UPLOAD DATA PART      =======================
// this method creates a new journey in the jourey collection
  void createJourney(String name) {
    var id = Uuid();
    String journeyId = id.v1(); // creating an if for each journey

    _firestore
        .collection(ref)
        .document(journeyId)
        .setData({'journey': name}); // uploading to the db
  }

//  =============     RETRIEVING THE DATA TO DISPLAY    ==================
// this method retrieves the collection from the db to be displayed in the dropdown menu in schedule
  Future<List<DocumentSnapshot>> getJourneys() =>
      _firestore.collection(ref).getDocuments().then((snaps) {
        return snaps.documents;
      });

//  =============     RETRIEVING THE DATA TO DISPLAY    ================== //  USING
  // this method retrieves the journey names from the db to be displayed in the journeys list option
  viewJourneys() async {
    return await Firestore.instance.collection(ref).getDocuments();
  }

  //   ================ DOCUMENT COUNT TO DISPLAY ON THE DASHBOARD   ====================
  // this method gets  the journey count
  Future<List<DocumentSnapshot>> getJourneyCount() {
    _firestore.collection(ref).getDocuments().then((snaps) {
      journeyCount = snaps.documents.length.toString();
    });

    return null;
  }

  // ===================         DELETE DATA PART          =========================
  // this method retrieves the snapshot from the db to delete
  getData() async {
    return Firestore.instance.collection(ref).snapshots();
  }

// this method deletes the selected record
  deleteData(documentId) {
    _firestore.collection(ref).document(documentId).delete().catchError((e) {
      print(e);
    });
  }
}
