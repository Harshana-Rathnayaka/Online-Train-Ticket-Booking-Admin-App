import 'package:admin_app/components/loading.dart';
import 'package:admin_app/db/train.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ViewTrains extends StatefulWidget {
  @override
  _ViewTrainsState createState() => _ViewTrainsState();
}

class _ViewTrainsState extends State<ViewTrains> {
  TrainService _trainService = TrainService();
  QuerySnapshot trains; // to store the train data coming from the db
  Stream trainList; // getting the snapshot to delete records

  @override
  void initState() {
    // getting the SNAPSHOT from the db and storing it
    _trainService.getData().then((results) {
      setState(() {
        trainList = results;
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
        title: Text("Trains"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                // reloading the list by retrieving the data again
                _trainService.viewTrains().then((results) {
                  setState(() {
                    trains = results;
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
        stream: trainList,
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
                  title: Text(snapshot.data.documents[i].data['train']),
                  onLongPress: () {
                    _deleteTrainAlert(snapshot.data.documents[i].documentID);
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

  // ======== ALERT BOX TO DELETE TRAIN ===========
  void _deleteTrainAlert(documentId) {
    var alert = new AlertDialog(
      title: Text("Delete"),
      content: Text("Are you sure you want to delete this?"),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            _trainService.deleteData(documentId);
            Fluttertoast.showToast(msg: 'Train deleted');
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
