import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ScheduleService {
  Firestore _firestore = Firestore.instance; // db instance
  String ref = "schedules"; // collection name
  String scheduleCount = "0"; // to store the schedule count

// =================      UPLOAD DATA PART      =======================
// this method uploads the schedule to the db
  void uploadSchedule(
      {String departureTime,
      String date,
      String train,
      String journey,
      int seats,
      double price,
      List classes,
      String image}) {
    // generating an id for the schedule
    var id = Uuid();
    String scheduleId = id.v1();

    _firestore.collection(ref).document(scheduleId).setData({
      'id': scheduleId,
      'departureTime': departureTime,
      'date': date,
      'train': train,
      'journey': journey,
      'seats': seats,
      'baseTicketPrice':
          price, // base ticket price is the price of a first class ticket. second class tickets are -50, observation is +50
      'availableClasses': classes,
      'image': image,
    }); // uploading to the db
  }

//  =============     RETRIEVING THE DATA TO DISPLAY    ================== // NOT USING 
// this method retrieves the data from the db to display
  getSchedule() async {
    return await Firestore.instance.collection(ref).getDocuments();
  }

//   ================ DOCUMENT COUNT TO DISPLAY ON THE DASHBOARD   ====================
  // this method gets  the schedule count
  Future<List<DocumentSnapshot>> getScheduleCount() {
    _firestore.collection(ref).getDocuments().then((snaps) {
      scheduleCount = snaps.documents.length.toString();
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
