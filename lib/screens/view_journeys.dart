import 'package:admin_app/components/loading.dart';
import 'package:admin_app/db/journey.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ViewJourneys extends StatefulWidget {
  @override
  _ViewJourneysState createState() => _ViewJourneysState();
}

class _ViewJourneysState extends State<ViewJourneys> {
  JourneyService _journeyService = JourneyService();
  QuerySnapshot journeys; // to store the journey data coming from the db
  Stream journeyList; // getting the snapshot to delete records

  @override
  void initState() {
    // getting the SNAPSHOT from the db and storing it
    _journeyService.getData().then((results) {
      setState(() {
        journeyList = results;
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
        title: Text("Journeys"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                // reloading the list by retrieving the data again
                _journeyService.viewJourneys().then((results) {
                  setState(() {
                    journeys = results;
                  });
                });
              }),
        ],
      ),
      //  =========== BODY   ===============
      body: _trainList(),
    );
  }

  Widget _trainList() {
    return StreamBuilder(
        stream: journeyList,
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
                  onLongPress: () {
                    _deleteJourneyAlert(snapshot.data.documents[i].documentID);
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

  // ======== ALERT BOX TO JOURNEY TRAIN ===========
  void _deleteJourneyAlert(documentId) {
    var alert = new AlertDialog(
      title: Text("Delete"),
      content: Text("Are you sure you want to delete this?"),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            _journeyService.deleteData(documentId);
            Fluttertoast.showToast(msg: 'Journey deleted');
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
}
