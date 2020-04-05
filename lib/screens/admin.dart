import 'package:admin_app/components/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:admin_app/screens/add_schedules.dart';
import 'package:admin_app/screens/instructions.dart';
import 'package:admin_app/screens/view_journeys.dart';
import 'package:admin_app/screens/view_schedules.dart';
import 'package:admin_app/screens/view_trains.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../db/journey.dart';
import '../db/train.dart';
import '../db/bookings.dart';
import '../db/revenue.dart';
import '../db/schedule.dart';
import '../db/users.dart';

// declaring the two pages
enum Page { dashboard, manage }

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> with SingleTickerProviderStateMixin {
  // 7 animation types with different delays
  Animation animation1,
      animation2,
      animation3,
      animation4,
      animation5,
      animation6,
      animation7;
  AnimationController animationController;

  Page _selectedPage =
      Page.dashboard; // making the selected page by default = to dashboard
  MaterialColor active = Colors.teal; // selected page color
  MaterialColor notActive = Colors.grey; // not selected page color
  MaterialColor cardValues = Colors.red; // colour for the values in the cards

  TextEditingController journeyController = TextEditingController();
  TextEditingController trainController = TextEditingController();

  GlobalKey<FormState> _journeyFormKey = GlobalKey();
  GlobalKey<FormState> _trainFormKey = GlobalKey();

  JourneyService _journeyService = JourneyService();
  TrainService _trainService = TrainService();
  ScheduleService _scheduleService = ScheduleService();
  UserService _userService = UserService();
  BookingService _bookingService = BookingService();
  RevenueService _revenueService = RevenueService();

// to store the revenue document snapshot
  List<DocumentSnapshot> revenue = <DocumentSnapshot>[];
  int _totalRevenue; // to store the revenue value

  _getRevenue() async {
    // get the data from the db to a documentsnapshot called data
    List<DocumentSnapshot> data = await _revenueService.getRevenue();
    print(data.length);
    setState(() {
      // store the data documentsnapshot in revenue documentsnapshot
      revenue = data;
      _totalRevenue = revenue[0].data['total'];
      print(revenue.length);
    });
  }

//  ============= REGARDING ANIMATIONS ================
  @override
  void initState() {
    _getRevenue();
    super.initState();
// intilizing the animation
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

// delay type 1
    animation1 = Tween(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.bounceOut));
// delay type 2
    animation2 = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
// delay type 3
    animation3 = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.6, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );

    // delay type 4
    animation4 = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.7, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );

    // delay type 5
    animation5 = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );

    // delay type 6
    animation6 = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.9, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );

    // delay type 7
    animation7 = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(1.0, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
  }

  // ==========================================================================

  @override
  Widget build(BuildContext context) {
    // starting the animation
    animationController.forward();
    // getting the count on startup to be displayed on the cards
    _trainService.getTrainCount();
    _journeyService.getJourneyCount();
    _scheduleService.getScheduleCount();
    _userService.getUserCount();
    _bookingService.getReservationCount();

// returning the animation builder before the scaffold
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return Scaffold(

// =========== the pages arent loaded again and again.
// instead we change whats being displayed when flat buttons are clicked ============
              appBar: AppBar(
                title: Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton.icon(
                        onPressed: () {
                          setState(() {
                            // getting the train count on page change
                            _trainService.getTrainCount();
                            _journeyService.getJourneyCount();
                            _scheduleService.getScheduleCount();
                            _userService.getUserCount();
                            _bookingService.getReservationCount();
                            _selectedPage = Page.dashboard;
                          });
                        },
                        icon: Icon(
                          Icons.dashboard,
                          color: _selectedPage == Page.dashboard
                              ? active
                              : notActive, // (IF ELSE)
                        ),
                        label: Text('Dashboard'),
                      ),
                    ),
                    Expanded(
                      child: FlatButton.icon(
                        onPressed: () {
                          setState(() {
                            _selectedPage = Page.manage;
                          });
                        },
                        icon: Icon(
                          Icons.sort,
                          color:
                              _selectedPage == Page.manage ? active : notActive,
                          // (IF ELSE)
                        ),
                        label: Text('Manage'),
                      ),
                    ),
                  ],
                ),
                elevation: 0.0,
                // backgroundColor: Colors.white,
              ),

// ================ BODY OF THE PAGE ===================

              body: _loadScreen());
        });
  }

// ==============     _loadScreen() METHOD     =============
// ========= SELECTING WHAT TO DISPLAY WHEN _loadScreen() IS CALLED ==========
  Widget _loadScreen() {
    // getting the size of the screen
    final double screenWidth = MediaQuery.of(context).size.width;

    switch (_selectedPage) {
// ========== STARTING CASE 1 =========
      case Page.dashboard:
        return Column(
          children: <Widget>[
            // giving animations
            Transform(
              transform: Matrix4.translationValues(
                  animation1.value * screenWidth, 0.0, 0.0),
              child: ListTile(
// ============  DISPLAYING THE REVENUE AND THE AMOUNT ==========
                subtitle: FlatButton.icon(
                  onPressed: null,
                  icon: Icon(
                    Icons.attach_money,
                    size: 25.0,
                    color: Colors.green[800],
                  ),
                  label: Tooltip(
                    message: "Total revenue",
                    child: Text(
                      "${_totalRevenue.toString()}.00",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.green.shade500,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  'Revenue',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.josefinSans(
                    fontSize: 24.0,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[500],
                  ),
                ),
              ),
            ),

// ============== REST OF THE FLAT BUTTONS USING CARDS ==================
            Expanded(
              child: GridView(
                // 2 cards per row
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: <Widget>[
                  // USERS CARD
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18.0, 18.0, 12.0, 18.0),
                    child: Transform(
                      transform: Matrix4.translationValues(
                          animation3.value * screenWidth, 0.0, 0.0),
                      child: Tooltip(
                        message: "Active users",
                        child: Card(
                          child: ListTile(
                            title: FlatButton.icon(
                              onPressed: () {
                                _userService.getUserCount();
                              },
                              icon: Icon(Icons.people_outline),
                              label: Text("Users"),
                            ),
                            subtitle: Text(
                              _userService.activeUsersCount,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: cardValues,
                                fontSize: 60.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // TRAINS CARD
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 18.0, 18.0, 18.0),
                    child: Transform(
                      transform: Matrix4.translationValues(
                          animation2.value * screenWidth, 0.0, 0.0),
                      child: Tooltip(
                        message: "Total number of trains",
                        child: Card(
                          child: ListTile(
                            title: FlatButton.icon(
                              onPressed: () {
                                // getting the train count on click, but doesnt work i think
                                _trainService.getTrainCount();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewTrains()),
                                );
                              },
                              icon: Icon(Icons.train),
                              label: Text("Trains"),
                            ),
                            subtitle: Text(
                              // traincount is assigned to the subtitle
                              _trainService.trainCount,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: cardValues,
                                fontSize: 60.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  //  SCHEDULE CARD
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18.0, 18.0, 12.0, 18.0),
                    child: Transform(
                      transform: Matrix4.translationValues(
                          animation5.value * screenWidth, 0.0, 0.0),
                      child: Tooltip(
                        message: "Total number of schedules",
                        child: Card(
                          child: ListTile(
                            title: FlatButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewSchedules()),
                                );
                              },
                              icon: Icon(Icons.calendar_today),
                              label: Expanded(
                                child: Text("Schedule"),
                              ),
                            ),
                            subtitle: Text(
                              // schedule count is assigned to the subtitle
                              _scheduleService.scheduleCount,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: cardValues,
                                fontSize: 60.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // BOOKINGS CARD
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 18.0, 18.0, 18.0),
                    child: Transform(
                      transform: Matrix4.translationValues(
                          animation4.value * screenWidth, 0.0, 0.0),
                      child: Tooltip(
                        message: "Total number of reservations",
                        child: Card(
                          child: ListTile(
                            title: FlatButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.recent_actors),
                              label: Text("Bookings"),
                            ),
                            subtitle: Text(
                              // reservation count is assigned to the subtitle
                              _bookingService.reservationsCount,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: cardValues,
                                fontSize: 60.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // JOURNEYS CARD
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18.0, 18.0, 12.0, 18.0),
                    child: Transform(
                      transform: Matrix4.translationValues(
                          animation7.value * screenWidth, 0.0, 0.0),
                      child: Tooltip(
                        message: "Total number of journeys",
                        child: Card(
                          child: ListTile(
                            title: FlatButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewJourneys()),
                                );
                              },
                              icon: Icon(Icons.location_searching),
                              label: Text("Journeys"),
                            ),
                            subtitle: Text(
                              // journey count is assigned to the subtitle
                              _journeyService.journeyCount,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: cardValues,
                                fontSize: 60.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // RETURNS CARD
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 18.0, 18.0, 18.0),
                    child: Transform(
                      transform: Matrix4.translationValues(
                          animation6.value * screenWidth, 0.0, 0.0),
                      child: Card(
                        child: ListTile(
                          title: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.close),
                              label: Text("Returns")),
                          subtitle: Text(
                            '0',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: cardValues, fontSize: 60.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
// END OF CASE 1
        break;

// ======== STARTING CASE 2 =======
      case Page.manage:
        return ListView(
          children: <Widget>[
            Tooltip(
              message: "Add a new schedule",
              child: ListTile(
                leading: Icon(Icons.add),
                title: Text("Add schedule"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => AddSchedule()));
                },
              ),
            ),
            Divider(),
            Tooltip(
              message: "The list of schedules",
              child: ListTile(
                leading: Icon(Icons.schedule),
                title: Text("Schedule list"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ViewSchedules()));
                },
              ),
            ),
            Divider(),
            Tooltip(
              message: "Add a new journey",
              child: ListTile(
                leading: Icon(Icons.transfer_within_a_station),
                title: Text("Add journey"),
                onTap: () {
                  _addJourneyAlert();
                },
              ),
            ),
            Divider(),
            Tooltip(
              message: "The list of journeys",
              child: ListTile(
                leading: Icon(Icons.departure_board),
                title: Text("Journeys list"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ViewJourneys()));
                },
              ),
            ),
            Divider(),
            Tooltip(
              message: "Add a new train",
              child: ListTile(
                leading: Icon(Icons.near_me),
                title: Text("Add trains"),
                onTap: () {
                  _addTrainAlert();
                },
              ),
            ),
            Divider(),
            Tooltip(
              message: "The list of trains",
              child: ListTile(
                leading: Icon(Icons.train),
                title: Text("Trains list"),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => ViewTrains()));
                },
              ),
            ),
            Divider(),
            Tooltip(
              message: "How to use the application",
              child: ListTile(
                leading: Icon(Icons.help),
                title: Text("Instructions"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => Instructions()));
                },
              ),
            ),
            Divider(),
            Tooltip(
              message: "About the application",
              child: ListTile(
                leading: Icon(Icons.info),
                title: Text("About"),
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationIcon: FlutterLogo(),
                    applicationName: "Book My Train Admin",
                    applicationVersion: "v1.0.0",
                    applicationLegalese: "Developed by Dreeko Corporations.",
                    children: <Widget>[
                      Text(
                        "I am Harshana Rathnayaka and this application was developed as a part of "
                        "my final project at the University of Plymouth, UK.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            letterSpacing: 0.5,
                            fontFamily: "Quicksand",
                            fontSize: 14.0),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "It's absolutely free for anyone to use.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            letterSpacing: 0.5,
                            fontFamily: "Quicksand",
                            fontSize: 14.0),
                      ),
                      Divider(),
                      SizedBox(height: 20.0),
                      Text(
                        "Thank You!",
                        style: TextStyle(
                            letterSpacing: 0.5,
                            fontFamily: "Quicksand",
                            fontSize: 14.0),
                      ),
                    ],
                  );
                },
              ),
            ),
            // dark mode switch
            Divider(),
            Tooltip(
              message: "How to use the application",
              child: Consumer<ThemeNotifier>(
                builder: (context, notifier, child) => SwitchListTile(
                  title: Text("Dark Mode"),
                  value: notifier.isDark,
                  onChanged: (value) {
                    notifier.toggleTheme();
                  },
                ),
              ),
            ),
          ],
        );
        break;
      default:
        return Container();
    }
  }

// ======== ALERT BOX TO ADD JOURNEY ===========
  void _addJourneyAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _journeyFormKey,
        child: TextFormField(
          controller: journeyController,
          validator: (value) {
            if (value.isEmpty) {
              return 'Journey name cannot be empty';
            }
            return null;
          },
          decoration: InputDecoration(hintText: "Add a journey"),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            if (journeyController.text != null) {
              _journeyService.createJourney(journeyController.text);
              journeyController.clear();
            }
            Fluttertoast.showToast(msg: 'Journey added');
            Navigator.pop(context);
          },
          child: Text(
            'ADD',
            style: TextStyle(color: Colors.teal),
          ),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'CANCEL',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
      ],
    );

// builder: (_) is another way of saying 'this context'
    showDialog(context: context, builder: (_) => alert);
  }

// ======== ALERT BOX TO ADD TRAIN ===========
  void _addTrainAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _trainFormKey,
        child: TextFormField(
          controller: trainController,
          validator: (value) {
            if (value.isEmpty) {
              return 'Train name cannot be empty';
            }
            return null;
          },
          decoration: InputDecoration(hintText: "Add a train"),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            if (trainController.text != null) {
              _trainService.createTrain(trainController.text);
              trainController.clear();
            }
            Fluttertoast.showToast(msg: 'Train added');
            Navigator.pop(context);
          },
          child: Text(
            'ADD',
            style: TextStyle(color: Colors.teal),
          ),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'CANCEL',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
      ],
    );

    showDialog(context: context, builder: (_) => alert);
  }
}
