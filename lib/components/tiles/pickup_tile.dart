import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garbagecan/model/pickup_data.dart';
import 'package:intl/intl.dart';

class PickupTile extends StatelessWidget {
  final Pickup pickup;

  const PickupTile({this.pickup});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 7,
              offset: Offset(0, 6),
            ),
          ],
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.event_note),
              Text(
                DateFormat.yMd().format(pickup.time.dateTime),
                style: TextStyle(fontSize: 18.0),
              ),
              Icon(Icons.alarm),
              Text(
                DateFormat.Hm().format(pickup.time.dateTime),
                style: TextStyle(fontSize: 18.0),
              ),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10.0)),
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.delete_forever,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text(
                                "Are you sure you want to cancel your pickup?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('pickups')
                                      .doc(pickup.id)
                                      .update({'taken': false});
                                  Navigator.pop(context);
                                },
                                child: Text('Yes'),
                              ),
                            ],
                          ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
