import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  TextEditingController _textController = TextEditingController();

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
        body: Padding(
          padding: EdgeInsets.only(top: 70.0, right: 35.0, left: 35.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
              Text(
                'Schedule your next PickUp',
                style: TextStyle(
                  color: Color(0xFF444444),
                  fontSize: 22.0,
                ),
              ),
              Text(
                'Address',
                style: TextStyle(
                  color: Color(0xFF444444),
                  fontSize: 18.0,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Icon(
                          Icons.gps_fixed_rounded,
                          color: Color(0xFF3A6ED4),
                          size: 32.0,
                        ),
                      ),
                      onTap: () {
                        print('this works');
                      },
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    flex: 15,
                    child: TextField(
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
                        hintText: 'Please enter your address',
                        helperText: 'Data format for the GPS call',
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
              RaisedButton(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ),
                  color: Color(0xFF3A6ED4),
                  onPressed: () {}),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
