import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garbagecan/model/date_slots_data.dart';
import 'package:garbagecan/model/pickup_data.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'select_pickup_screen.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarController _calendarController;
  FirebaseAuth _auth = FirebaseAuth.instance;
  User loggedInUser;

  DateTime selectedDate;

  void getCurrentUser() {
    User user = _auth.currentUser;

    if (user != null) {
      loggedInUser = user;
    }
  }

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    getCurrentUser();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.2, 0.5, 0.9],
          colors: [
            Color(0xFF97FCBE),
            Color(0xFFb0f6d6),
            Color(0xFF97CFFC),
          ],
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.list,
            color: Colors.white,
            size: 25.0,
          ),
          backgroundColor: Color(0xFF3A6ED4),
          onPressed: () {
            if (Provider.of<PickupData>(context, listen: false)
                    .getActivePickups(loggedInUser.uid) !=
                null) {
              if (_isSameDay(
                Provider.of<PickupData>(context, listen: false)
                    .getActivePickups(loggedInUser.uid)[0]
                    .time
                    .dateTime,
                selectedDate,
              )) {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.ERROR,
                  title: 'You already scheduled a pickup',
                  desc:
                      'To give others also the chance to schedule a pickup, you can only create one per day',
                  btnCancelOnPress: () {},
                )..show();
              } else {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: SelectPickUpScreen(
                        selectedDate: selectedDate == null
                            ? DateTime.parse('9999-01-01')
                            : selectedDate,
                      ),
                    ),
                  ),
                );
              }
            } else {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: SelectPickUpScreen(
                      selectedDate: selectedDate == null
                          ? DateTime.parse('9999-01-01')
                          : selectedDate,
                    ),
                  ),
                ),
              );
            }
          },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 60.0, right: 35.0, left: 35.0, bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 5.0,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      child: Icon(
                        Icons.restore_from_trash,
                        size: 35.0,
                        color: Color(0xFF3A6ED4),
                      ),
                      radius: 35.0,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    'Schedule your next PickUp',
                    style: TextStyle(
                      color: Color(0xFF444444),
                      fontSize: 22.0,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: TableCalendar(
                  events: Provider.of<DateSlotsData>(context).events(),
                  calendarController: _calendarController,
                  calendarStyle: CalendarStyle(
                    selectedColor: Color(0xFF3A6ED4),
                    todayColor: Color(0xB33A6ED4),
                  ),
                  headerStyle: HeaderStyle(
                    titleTextStyle: TextStyle(
                      fontSize: 20.0,
                      color: Color(0xFF444444),
                    ),
                    formatButtonShowsNext: false,
                    formatButtonDecoration: BoxDecoration(
                      color: Color(0xFF3A6ED4),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    formatButtonTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                    formatButtonPadding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  ),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  onDaySelected: (day, events, holidays) {
                    selectedDate =
                        DateTime.parse(DateFormat('yyyy-MM-dd').format(day));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
