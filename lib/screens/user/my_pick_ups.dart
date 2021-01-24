import 'package:flutter/material.dart';
import 'package:garbagecan/components/tiles/pickup_tile_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyPickups extends StatefulWidget {
  @override
  _MyPickupsState createState() => _MyPickupsState();
}

class _MyPickupsState extends State<MyPickups> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User loggedInUser;

  void getCurrentUser() {
    final User user = _auth.currentUser;

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
          padding:
              EdgeInsets.only(top: 60.0, right: 35.0, left: 35.0, bottom: 30.0),
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
                'Here is a list of all your pickups',
                style: TextStyle(
                  color: Color(0xFF444444),
                  fontSize: 22.0,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Expanded(
                child: PickupTileView(
                  userID: loggedInUser.uid,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
