import 'package:flutter/material.dart';
import 'package:garbagecan/components/date_tile_view.dart';
import 'package:garbagecan/model/date_slots_data.dart';
import 'package:provider/provider.dart';

class SelectPickUpScreen extends StatefulWidget {
  final selectedDate;

  SelectPickUpScreen({this.selectedDate});

  @override
  _SelectPickUpScreenState createState() => _SelectPickUpScreenState();
}

class _SelectPickUpScreenState extends State<SelectPickUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Text(
              'Available Time-Slots',
              style: TextStyle(color: Color(0xFF444444), fontSize: 22.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Provider.of<DateSlotsData>(context)
                        .dateSlots[widget.selectedDate] ==
                    null
                ? Text(
                    'No time slots available right now',
                    style: TextStyle(color: Color(0xFF444444), fontSize: 18.0),
                  )
                : DateListTileView(
                    selectedDate: widget.selectedDate,
                  ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RaisedButton(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white, fontSize: 24.0),
                      ),
                      color: Colors.grey,
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  RaisedButton(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Text(
                        'Select',
                        style: TextStyle(color: Colors.white, fontSize: 24.0),
                      ),
                      color: Color(0xFF3A6ED4),
                      onPressed: () {
                        Navigator.pushNamed(context, '/contact');
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
