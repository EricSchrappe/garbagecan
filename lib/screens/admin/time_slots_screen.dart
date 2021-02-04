import 'package:flutter/material.dart';
import 'package:garbagecan/components/picker/date_picker.dart';
import 'package:garbagecan/components/picker/time_picker.dart';
import 'package:garbagecan/model/date_slots_data.dart';
import 'package:provider/provider.dart';

class TimeSlots extends StatefulWidget {
  @override
  _TimeSlotsState createState() => _TimeSlotsState();
}

class _TimeSlotsState extends State<TimeSlots> {
  TextEditingController _controllerBeginDate = TextEditingController();
  TextEditingController _controllerEndDate = TextEditingController();
  TextEditingController _controllerStartTime = TextEditingController();
  TextEditingController _controllerEndTime = TextEditingController();

  GlobalKey<ScaffoldState> _scaffold = GlobalKey();

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
        key: _scaffold,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 60.0, right: 35.0, left: 35.0, bottom: 30.0),
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
                    height: 20.0,
                  ),
                  Text(
                    'Please specify the time slots',
                    style: TextStyle(
                      color: Color(0xFF444444),
                      fontSize: 22.0,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Begin date',
                      style: TextStyle(
                        color: Color(0xFF444444),
                        fontSize: 18.0,
                      ),
                    ),
                    TextFieldDatePicker(
                      controller: _controllerBeginDate,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      'End date',
                      style: TextStyle(
                        color: Color(0xFF444444),
                        fontSize: 18.0,
                      ),
                    ),
                    TextFieldDatePicker(
                      controller: _controllerEndDate,
                      withClearButton: true,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      'Time range',
                      style: TextStyle(
                        color: Color(0xFF444444),
                        fontSize: 18.0,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Expanded(
                          child: TextFieldTimePicker(
                            controller: _controllerStartTime,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(
                            ':',
                            style: TextStyle(fontSize: 30.0),
                          ),
                        ),
                        Expanded(
                          child: TextFieldTimePicker(
                            controller: _controllerEndTime,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 50.0, bottom: 15.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          color: Color(0xFF3A6ED4),
                          child: Text(
                            'Add Time-Slots',
                            style:
                                TextStyle(color: Colors.white, fontSize: 24.0),
                          ),
                          onPressed: () async {
                            await Provider.of<DateSlotsData>(context,
                                    listen: false)
                                .addDateSlots(
                                    beginDateString: _controllerBeginDate.text,
                                    endDateString: _controllerEndDate.text,
                                    startTimeString: _controllerStartTime.text,
                                    endTimeString: _controllerEndTime.text);
                            _scaffold.currentState.showSnackBar(SnackBar(
                              content: Text("Timeslots added"),
                            ));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
