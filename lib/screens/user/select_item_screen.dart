import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garbagecan/components/tiles/item_tile_view.dart';
import 'package:garbagecan/model/date_slots_data.dart';
import 'package:garbagecan/model/item_data.dart';
import 'package:garbagecan/model/pickup_data.dart';
import 'package:provider/provider.dart';

class SelectTrashItemsScreen extends StatefulWidget {
  @override
  _SelectTrashItemsScreenState createState() => _SelectTrashItemsScreenState();
}

class _SelectTrashItemsScreenState extends State<SelectTrashItemsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User loggedInUser;

  void getCurrentUser() {
    final user = _auth.currentUser;

    if (user != null) {
      loggedInUser = user;
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;

    DateTime selectedDate;
    GeoPoint gps;
    String name;
    String phone;
    String email;
    String address;

    args.forEach((key, value) {
      if (key == 'name') {
        name = value;
      } else if (key == 'phone') {
        phone = value;
      } else if (key == 'email') {
        email = value;
      } else if (key == 'selectedDate') {
        selectedDate = value;
      } else if (key == 'address') {
        address = value;
      } else if (key == 'gps') {
        gps = value;
      }
    });

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
                    'Here you can specify your trash items',
                    style: TextStyle(
                      color: Color(0xFF444444),
                      fontSize: 22.0,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select your items',
                      style: TextStyle(
                        color: Color(0xFF444444),
                        fontSize: 18.0,
                      ),
                    ),
                    Expanded(flex: 15, child: ItemTileView()),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RaisedButton(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24.0),
                                ),
                                color: Colors.grey,
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                            RaisedButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              color: Color(0xFF3A6ED4),
                              child: Text(
                                'Request PickUp',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24.0),
                              ),
                              onPressed: () {
                                final timeSlot = Provider.of<DateSlotsData>(
                                        context,
                                        listen: false)
                                    .getSelectedTime(selectedDate);
                                Provider.of<PickupData>(context, listen: false)
                                    .addPickup(Pickup(
                                  id: timeSlot.id,
                                  uid: loggedInUser.uid,
                                  address: address,
                                  gps: gps,
                                  email: email,
                                  name: name,
                                  phoneNumber: phone,
                                  time: timeSlot,
                                  items: Provider.of<ItemData>(context,
                                          listen: false)
                                      .getSelectedItems(),
                                ));
                                print(Provider.of<PickupData>(context,
                                        listen: false)
                                    .pickupData
                                    .length);
                                print(Provider.of<PickupData>(context,
                                        listen: false)
                                    .pickupData);
                                Provider.of<ItemData>(context, listen: false)
                                    .uncheckItems();
                                Navigator.pushNamed(context, '/thanks');
                              },
                            ),
                          ],
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
