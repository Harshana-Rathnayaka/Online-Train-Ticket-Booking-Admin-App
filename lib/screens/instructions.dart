import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Instructions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
          ),
        ),
        title: Text(
          "Instructions",
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 40.0,
          ),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text(
                    "Please read the following instructions",
                    style: GoogleFonts.aBeeZee(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                      wordSpacing: 1.0,
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Divider(
                    thickness: 2.0,
                    color: Colors.teal,
                  ),
                  Text(
                    "How to add a new schedule?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Adding a schedule is easy. Go to the add schedule page from the management menu. "
                      "Fill all the required fields and click the add schedule button.",
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.montserrat(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "IMPORTANT : You can select only one image. A landscape image is preffered. "
                        "The default number of seats per carriage is 20. This is a fixed "
                        "number and you can't change it. You need to check the available classes at "
                        "all times. You must always enter the first class price. The rest will be "
                        "calculated automatically.",
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.montserrat(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    "How to add delete a schedule?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "To delete a schedule go to the schedule list page from the management page and "
                      "press and hold on the schedule you want to delete. An alert box will pop-up "
                      "asking you to confirm the deletion process. Click YES to proceed and NO to cancel.",
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.montserrat(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "IMPORTANT : You can't update a schedule. So, if you made any mistake, you have "
                        "to delete that schedule and start again from scratch.",
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.montserrat(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    "How to add a new journey?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Go to the add journey page from the management page. Type the journey "
                      "and press OK.",
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.montserrat(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "IMPORTANT : The journey name must always contain the departing station "
                        "name and the arrival station name. (ex: Colombo - Kandy)",
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.montserrat(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    "How to delete a journey?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Go to the journey list page from the management page. Tap and hold on the "
                      "journey you want to delete. An alert box will pop-up asking you to confirm "
                      "the deletion. Click YES to proceed and NO to cancel.",
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.montserrat(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "IMPORTANT : You can't edit a journey. If you make a mistake, you have to delete "
                        "and add it again.",
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.montserrat(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    "How to add a new train?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Go to the add train page from the management page. Type the train name "
                      "and press OK.",
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.montserrat(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "IMPORTANT : Only the luxurious and express trains must be entered. And these "
                        "must be the ones that passengers are allowed reserve tickets in.",
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.montserrat(
                          // color: Colors.blueGrey[600],
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    "How to delete a train?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Go to the train list page from the management page. Tap and hold on the "
                      "train you want to delete. An alert box will pop-up asking you to confirm "
                      "the deletion. Click YES to proceed and NO to cancel.",
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.montserrat(
                        // color: Colors.blueGrey[600],
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "IMPORTANT : You can't edit a train name. If you make a mistake, you have to delete "
                        "and add it again.",
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.montserrat(
                          // color: Colors.blueGrey[600],
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    "Schedule Management",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "A schedule must be created at least two days before actual date of departure. "
                      "These schedules will not be valid after their actual departure date. "
                      "You must delete the outdated schedules as soon as possible.",
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.montserrat(
                        // color: Colors.blueGrey[600],
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "IMPORTANT : Deleting a schedule as soon as the train leaves the station is "
                        "prefferable. You must add new schedules evryday.",
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.montserrat(
                          // color: Colors.blueGrey[600],
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    "Dashboard",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "The various cards in the dashboard shows the various information such as the active "
                      "number of users, the number of schedules, the number of trains and journeys as well "
                      "as the number of bookings.",
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.montserrat(
                        // color: Colors.blueGrey[600],
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "IMPORTANT : The dashboard updates everytime you open the dashboard. The revenue "
                        "indicates the total income from the reservations.",
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.montserrat(
                          // color: Colors.blueGrey[600],
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
