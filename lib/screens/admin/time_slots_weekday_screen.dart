import 'package:flutter/material.dart';
import 'package:garbagecan/components/picker/time_picker.dart';
import 'package:garbagecan/model/date_slots_data.dart';
import 'package:provider/provider.dart';

class TimeSlotsWeekday extends StatefulWidget {
  @override
  _TimeSlotsWeekdayState createState() => _TimeSlotsWeekdayState();
}

class _TimeSlotsWeekdayState extends State<TimeSlotsWeekday> {
  TextEditingController _controllerWeekday = TextEditingController();
  TextEditingController _controllerStartTime = TextEditingController();
  TextEditingController _controllerEndTime = TextEditingController();
  double _currentSliderValue = 30;
  int weekday = 1;
  List<bool> isSelected = [true, false, false, false, false, false, false];

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
                    ToggleButtons(
                      children: [
                        Text('Mon'),
                        Text('Tue'),
                        Text('Wed'),
                        Text('Thu'),
                        Text('Fri'),
                        Text('Sat'),
                        Text('Sun'),
                      ],
                      fillColor: Color(0xFF3A6ED4),
                      selectedColor: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      borderWidth: 1.75,
                      borderColor: Color(0xFF3A6ED4),
                      selectedBorderColor: Color(0xFF3A6ED4),
                      onPressed: (int index) {
                        setState(() {
                          for (int buttonIndex = 0;
                              buttonIndex < isSelected.length;
                              buttonIndex++) {
                            if (buttonIndex == index) {
                              isSelected[buttonIndex] = true;
                              weekday = buttonIndex + 1;
                            } else {
                              isSelected[buttonIndex] = false;
                            }
                          }
                        });
                      },
                      isSelected: isSelected,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      'Select number of days',
                      style: TextStyle(
                        color: Color(0xFF444444),
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      textAlign: TextAlign.center,
                      readOnly: true,
                      controller: _controllerWeekday
                        ..text = _currentSliderValue.round().toString(),
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
                        isDense: true,
                        contentPadding: EdgeInsets.all(8.0),
                      ),
                    ),
                    Slider(
                      value: _currentSliderValue,
                      min: 0,
                      max: 120,
                      divisions: 4,
                      label: _currentSliderValue.round().toString(),
                      activeColor: Color(0xFF3A6ED4),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value;
                          _controllerWeekday.text = value.round().toString();
                        });
                      },
                    ),
                    SizedBox(
                      height: 20.0,
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
                          onPressed: () {
                            Provider.of<DateSlotsData>(context, listen: false)
                                .addDateSlotsWeekday(
                                    weekday: weekday,
                                    dayNumber: _currentSliderValue.round(),
                                    startTimeString: _controllerStartTime.text,
                                    endTimeString: _controllerEndTime.text);
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
