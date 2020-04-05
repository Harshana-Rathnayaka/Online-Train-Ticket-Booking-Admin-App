import 'dart:io';

import 'package:admin_app/components/loading.dart';
import 'package:admin_app/db/schedule.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:admin_app/db/journey.dart';
import 'package:admin_app/db/train.dart';
import 'package:intl/intl.dart';

class AddSchedule extends StatefulWidget {
  @override
  _AddScheduleState createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  JourneyService _journeyService = JourneyService();
  TrainService _trainService = TrainService();
  ScheduleService _scheduleService = ScheduleService();

  // Defining colors for reusablity
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;

// form key to identify the state of the add schedule form
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController departureTimeController = TextEditingController();
  TextEditingController seatsController = TextEditingController();
  TextEditingController priceController = TextEditingController();

// lists coming from the db
  List<DocumentSnapshot> journeys = <DocumentSnapshot>[];
  List<DocumentSnapshot> trains = <DocumentSnapshot>[];

// creating dropdown menus for the ui
  List<DropdownMenuItem<String>> journeysDropdown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> trainsDropdown = <DropdownMenuItem<String>>[];

// to get the current value to display
  String _currentJourney;
  String _currentTrain;

// selecting available classes
  List<String> selectedClasses = <String>[];

// uploading the image
  File _image;

// loading indicator
  bool isLoading = false;

// for the date and time selections
  DateTime _date;
  TimeOfDay _departureTime;
  TimeOfDay _time = TimeOfDay.now();

// onTime or delayed switch and today switch
  bool onTime = false;
  bool today = false;

  @override
  void initState() {
    _getJourneys();
    _getTrains();
    
    super.initState();
  }

//   =============   JOURNEY LIST    =============

  // creating the journey list to be inserted into the dropdown list
  List<DropdownMenuItem<String>> getJourneysDropdown() {
    List<DropdownMenuItem<String>> journeyList = new List();
    // for each journey type inside journeys list from db,
    for (int i = 0; i < journeys.length; i++) {
      setState(() {
        journeyList.insert(
          0,
          DropdownMenuItem(
              // inserting to the dropdown
              child: Text(journeys[i].data['journey']),
              value: journeys[i].data['journey']),
        );
      });
    }
    return journeyList;
  }

//   =============   TRAIN LIST       =================

  // creating the trains list to be inserted into the dropdown list
  List<DropdownMenuItem<String>> getTrainsDropdown() {
    List<DropdownMenuItem<String>> trainList = new List();
    // for each train name inside trains list from db,
    for (int i = 0; i < trains.length; i++) {
      setState(() {
        trainList.insert(
          0,
          DropdownMenuItem(
              // inserting to the dropdown
              child: Text(trains[i].data['train']),
              value: trains[i].data['train']),
        );
      });
    }
    return trainList;
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
        title: Text("Add schedule"),
      ),

//    ============== FORM BODY =================
      body: Form(
        key: _formKey,
        // makes the page scorllable
        child: SingleChildScrollView(
          child: isLoading
              // if(? means if) isLoading is true display the indicator
              ? Center(
                  // check
                  child: Padding(
                    padding:
                        const EdgeInsets.fromLTRB(50.0, 250.0, 50.0, 250.0),
                    child: Loading(),
                  ),
                )
              // else(: means else) display the form
              : Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        // =============== SELECT IMAGE BUTTON  ==================
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Tooltip(
                              message: "Select an image",
                              child: OutlineButton(
                                borderSide: BorderSide(
                                    color: grey.withOpacity(0.5), width: 2.5),
                                // select image on button press
                                onPressed: () {
                                  _selectImage(
                                      ImagePicker.pickImage(
                                          source: ImageSource.gallery),
                                      1);
                                },
                                // displaying the image after selecting
                                child: _displayChild(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

//  ==============   SELECT THE DEPARTURE TIME   ==================
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2.0, 2.0, 12.0, 0.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            tooltip: "Pick a time",
                            icon: Icon(
                              Icons.alarm_add,
                              color: Colors.grey.shade600,
                            ),
                            onPressed: () {
                              selectTime(context);
                            },
                          ),
                          Text(
                            _departureTime == null
                                ? "Pick the time"
                                : _departureTime.format(context),
                          ),

//  ==============   SELECT THE DEPARTURE DATE   ==================
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(30.0, 2.0, 0.0, 0.0),
                            child: IconButton(
                              tooltip: "Pick a date",
                              icon: Icon(
                                Icons.date_range,
                                color: Colors.grey.shade600,
                              ),
                              onPressed: () {
                                showDatePicker(
                                  context: context,
                                  initialDate:
                                      _date == null ? DateTime.now() : _date,
                                  firstDate: DateTime(2019),
                                  lastDate: DateTime(2200),
                                ).then((date) {
                                  setState(() {
                                    _date = date;
                                  });
                                });
                              },
                            ),
                          ),
                          Text(_date == null
                              ? "Pick the date"
                              : DateFormat("dd-MM-yyyy")
                                  .format(DateTime.parse("$_date"))),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 0.0),
                    ),

                    // =============     SELECT JOURNEY      ===================
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Journey:",
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ),
                        Tooltip(
                          message: "Select the journey",
                          child: DropdownButton(
                            items: journeysDropdown,
                            onChanged: changeSelectedJourney,
                            value: _currentJourney,
                          ),
                        ),
                      ],
                    ),

                    // =============     SELECT A TRAIN NAME      ===================
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Train:",
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ),
                        Tooltip(
                          message: "Select the train",
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                16.0, 12.0, 8.0, 12.0),
                            child: DropdownButton(
                              items: trainsDropdown,
                              onChanged: changeSelectedTrain,
                              value: _currentTrain,
                            ),
                          ),
                        ),
                      ],
                    ),

//  ============ NUMBER OF AVAILABLE SEATS   ===============
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 0.0),
                      child: TextFormField(
                        maxLength: 2,
                        controller: seatsController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.airline_seat_recline_normal,
                            color: Colors.grey.shade600,
                          ),
                          labelText: "Seats Per Carriage:",
                          hintText: "20",
                          hintStyle: TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter the number of seats available *";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),

// ============== BASE PRICE ==================
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 0.0),
                      child: TextFormField(
                        maxLength: 6,
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.attach_money,
                            color: Colors.grey.shade600,
                          ),
                          labelText: "First Class Price:",
                          hintText: "300.00",
                          hintStyle: TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter the base price *";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),

// ===============       SELECT THE AVAILABLE CARRIAGES      =====================
                    Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 0.0),
                          child: Text(
                            "Available Classes:",
                          ),
                        ),
                      ],
                    ),

                    //  CARRIAGES LIST (checkboxes)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                            checkColor: Colors.teal,
                            // if the list contains the value 1
                            value: selectedClasses.contains("1"),
                            // pass the value 1 into the method
                            onChanged: (value) => changeSelectedClass('1'),
                          ),
                          Text("1"),
                          Checkbox(
                            checkColor: Colors.teal,
                            value: selectedClasses.contains("2"),
                            onChanged: (value) => changeSelectedClass('2'),
                          ),
                          Text("2"),
                          Checkbox(
                            checkColor: Colors.teal,
                            value: selectedClasses.contains("Observation"),
                            onChanged: (value) =>
                                changeSelectedClass('Observation'),
                          ),
                          Text("Observation"),
                        ],
                      ),
                    ),

//  =============== ADD SCHEDULE BUTTON  ===================
                    Tooltip(
                      message: "Create new schedule",
                      child: FlatButton(
                        color: Colors.teal,
                        textColor: white,
                        child: Text('Add schedule'),
                        onPressed: () {
                          validateAndUpload();
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  _getJourneys() async {
    // get the data from the db to a documentsnapshot called data
    List<DocumentSnapshot> data = await _journeyService.getJourneys();
    print(data.length);
    setState(() {
      journeys =
          data; // store the data documentsnapshot in journeys documentsnapshot
      journeysDropdown =
          getJourneysDropdown(); // storing the list in a dropdown
      _currentJourney = journeys[0].data['journey'];
      print(journeys.length);
    });
  }

  // same as the above method, for trains
  _getTrains() async {
    List<DocumentSnapshot> data = await _trainService.getTrains();
    print(data.length);
    setState(() {
      trains = data;
      trainsDropdown = getTrainsDropdown();
      _currentTrain = trains[0].data['train'];
      print(trains.length);
    });
  }

  // when a dropdown item is clicked, that item is assigned to the selected item
  changeSelectedJourney(String selectedJourney) {
    setState(() => _currentJourney = selectedJourney);
  }

  // same as above for trains
  changeSelectedTrain(String selectedTrain) {
    setState(() => _currentTrain = selectedTrain);
  }

  // changing the checkboxes
  // this method handles the checkboxes checking and unchecking
  void changeSelectedClass(String selectedClass) {
    if (selectedClasses.contains(selectedClass)) {
      // if the checked class is already in the list (it means that it was already selected and now it is not)
      setState(() {
        selectedClasses.remove(selectedClass); // remove if it was selected
      });
    } else {
      setState(() {
        selectedClasses.insert(0,
            selectedClass); // add if it wasn't selected before but selected now
      });
    }
  }

  // select a image from the phone on button click
  void _selectImage(Future<File> pickImage, int imageNumber) async {
    File tempImage = await pickImage; // store the image in a temp
    switch (imageNumber) {
      case 1:
        setState(() => _image = tempImage); // asign the temp to the image
        break;
    }
  }

  // this handles the actual display function of the button
  Widget _displayChild() {
    if (_image == null) {
      // if an image wasn't selected display the empty box with '+' icon
      return Padding(
        padding: const EdgeInsets.fromLTRB(14.0, 40.0, 14.0, 40.0),
        child: Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      // if an image is selected display it
      return Image.file(
        _image,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

// validating the form and uploading to the db
  void validateAndUpload() async {
    if (_formKey.currentState.validate()) {
      setState(() => isLoading = true);

      if (_image != null) {
        if (selectedClasses.isNotEmpty) {
          String imageUrl;

          final FirebaseStorage storage =
              FirebaseStorage.instance; // getting the db
          final String picture =
              "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg"; // creating a different name for each pic

          StorageUploadTask task =
              storage.ref().child(picture).putFile(_image); // uploading task

          task.onComplete.then((snapshot) async {
            imageUrl = await snapshot.ref
                .getDownloadURL(); // get the url for the pic from db when complete

            // passing the values to be uploaded to the db
            _scheduleService.uploadSchedule(
              departureTime: _departureTime.format(context),
              date: DateFormat("dd-MM-yyyy").format(DateTime.parse("$_date")),
              train: _currentTrain,
              journey: _currentJourney,
              seats: int.parse(seatsController.text),
              price: double.parse(priceController.text),
              classes: selectedClasses,
              image: imageUrl,
            );

            // if uploading is successful reset the form
            _formKey.currentState.reset();
            setState(() {
              isLoading = false;
              _image = null;
              seatsController.clear();
              priceController.clear();
              selectedClasses.clear();
            });
            Fluttertoast.showToast(msg: "Schedule added");
          });
        } else {
          setState(() => isLoading = false);
          Fluttertoast.showToast(msg: "Select at least one class");
        }
      } else {
        setState(() => isLoading = false);
        Fluttertoast.showToast(msg: "An image must be provided");
      }
    }
  }

// Selecting the time
  Future<Null> selectTime(BuildContext context) async {
    _departureTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    setState(() {
      _time = _departureTime;
    });
  }
}
