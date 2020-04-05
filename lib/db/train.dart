import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class TrainService {
  Firestore _firestore = Firestore.instance; // db instance
  String ref = "trains"; // collection name
  String trainCount = "0"; // to store the train count

// =================      UPLOAD DATA PART      =======================
// this method creates a new train name in the train collection
  void createTrain(String name) {
    var id = Uuid();
    String trainId = id.v1(); // generating an id for each train

    _firestore
        .collection(ref)
        .document(trainId)
        .setData({'train': name}); // uploading to the db
  }

//  =============     RETRIEVING THE DATA TO DISPLAY    ==================
// this method retrieves the collection from the db for the dropdown menu parts
  Future<List<DocumentSnapshot>> getTrains() =>
      _firestore.collection(ref).getDocuments().then((snaps) {
        print(snaps.documents.length);
        return snaps.documents;
      });

//  =============     RETRIEVING THE DATA TO DISPLAY    ================== //  USING
// this method retrieves the train names from the db to be displayed in the train list option
  viewTrains() async {
    return await Firestore.instance.collection(ref).getDocuments();
  }

  //   ================ DOCUMENT COUNT TO DISPLAY ON THE DASHBOARD   ====================
  // this method gets  the train count
  Future<List<DocumentSnapshot>> getTrainCount() {
    _firestore.collection(ref).getDocuments().then((snaps) {
      trainCount = snaps.documents.length.toString();
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
