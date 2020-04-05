import 'package:admin_app/components/loading.dart';
import 'package:admin_app/db/schedule.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ViewSchedules extends StatefulWidget {
  @override
  _ViewSchedulesState createState() => _ViewSchedulesState();
}

class _ViewSchedulesState extends State<ViewSchedules> {
  ScheduleService _scheduleService = ScheduleService();
  Stream schedules; // to store the snapshot to delete

  @override
  void initState() {
    // getting the SNAPSHOT from the db and storing it
    _scheduleService.getData().then((results) {
      setState(() {
        schedules = results;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
        title: Text("Schedules"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                // reloading the list by retrieving the data again
                _scheduleService.getData().then((results) {
                  setState(() {
                    schedules = results;
                  });
                });
              }),
        ],
      ),

//  =========== BODY   ===============
      body: _scheduleList(),
    );
  }

  Widget _scheduleList() {
    return StreamBuilder(
        stream: schedules,
        builder: (context, snapshot) {
          // if the snapshot is empty when its first called display the loading widget
          if (snapshot == null) {
            return Loading();
            // if the snapshot has data
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              padding: EdgeInsets.all(5.0),
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(snapshot.data.documents[i].data['journey']),
                  subtitle: Text(snapshot.data.documents[i].data['train']),
                  trailing:
                      Text(snapshot.data.documents[i].data['departureTime']),
                  onLongPress: () {
                    _deleteScheduleAlert(snapshot.data.documents[i].documentID);
                  },
                );
              },
            );
          } else {
            // if the process is delayed
            return Loading();
          }
        });
  }

// ======== ALERT BOX TO DELETE SCHEDULE ===========
  void _deleteScheduleAlert(documentId) {
    var alert = new AlertDialog(
      title: Text("Delete"),
      content: Text("Are you sure you want to delete this?"),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            _scheduleService.deleteData(documentId);
            Fluttertoast.showToast(msg: 'Schedule deleted');
            Navigator.pop(context);
          },
          child: Text(
            'YES',
            style: TextStyle(color: Colors.teal),
          ),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'NO',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
      ],
    );

    showDialog(context: context, builder: (_) => alert);
  }

  // //  ============ UPDATE SCHEDULE DIALOG BOX ================
  // Future<bool> updateDialog(BuildContext context, selectedDoc) async {
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text("Update Data", style: TextStyle(fontSize: 15.0)),
  //           content: Column(
  //             children: <Widget>[
  //               TextField(
  //                 decoration: InputDecoration(hintText: "Schedule name"),
  //                 onChanged: (value) {
  //                   this.journey = value;
  //                 },
  //               ),
  //             ],
  //           ),
  //           actions: <Widget>[
  //             FlatButton(
  //               child: Text("ADD"),
  //               textColor: Colors.teal,
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //                 _scheduleService
  //                     .updateSchedule(selectedDoc, {
  //                       'journey': this.journey,
  //                       'train': this.train,
  //                     })
  //                     .then((result) {})
  //                     .catchError((e) {
  //                       print(e);
  //                     });
  //               },
  //             ),
  //           ],
  //         );
  //       });
  // }
}
