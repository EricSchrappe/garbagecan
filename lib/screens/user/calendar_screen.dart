import 'package:flutter/material.dart';
import 'package:garbagecan/model/date_slots_data.dart';
import 'package:garbagecan/services/location_data.dart';
import 'package:table_calendar/table_calendar.dart';
import 'select_pickup_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarController _calendarController;
  TextEditingController _textController = TextEditingController();

  String addressText = 'Please enter your address';
  LocationData location = LocationData();
  DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    location.getLocation();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

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
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.list,
            color: Colors.white,
            size: 25.0,
          ),
          backgroundColor: Color(0xFF3A6ED4),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: SelectPickUpScreen(
                    selectedDate: selectedDate,
                  ),
                ),
              ),
            );
          },
        ),
        body: Column(
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          child: Icon(
                            Icons.gps_fixed_rounded,
                            color: Color(0xFF3A6ED4),
                            size: 32.0,
                          ),
                          onTap: () {
                            location
                                .getAddressForCoordinates()
                                .then((String address) {
                              setState(() {
                                addressText = address;
                              });
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        flex: 15,
                        child: TextField(
                          readOnly: addressText != 'Please enter your address'
                              ? true
                              : false,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFF6F6F6),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF3A6ED4),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF3A6ED4),
                              ),
                            ),
                            hintText: addressText,
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: Color(0xFF3A6ED4),
                              ),
                              onPressed: () => _textController.clear(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                        ),
                        color: Color(0xFF3A6ED4),
                        onPressed: () {}),
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
                  events: Provider.of<DateSlotsData>(context).dateSlots,
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
