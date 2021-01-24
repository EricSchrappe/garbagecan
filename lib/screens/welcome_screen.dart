import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

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
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.only(right: 35.0, left: 35.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 5.0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    child: Icon(
                      Icons.restore_from_trash,
                      size: 60.0,
                      color: Color(0xFF3A6ED4),
                    ),
                    radius: 60.0,
                    backgroundColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Text(
                    'Welcome to GarbageCan',
                    style: TextStyle(
                      color: Color(0xFF444444),
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Center(
                  child: Text(
                    '- sustainable waste management -',
                    style: TextStyle(
                      color: Color(0xFF444444),
                      fontSize: 18.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                RaisedButton(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  color: Color(0xFF3A6ED4),
                  child: Text(
                    'User perspective',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0),
                  ),
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    final user = await _auth.signInWithEmailAndPassword(
                        email: 'group20@tu-berlin.de', password: 'Group20I&E!');
                    if (user != null) {
                      Navigator.pushNamed(context, '/userTabs');
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  color: Color(0xFF43BC72),
                  child: Text(
                    'Admin perspective',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0),
                  ),
                  onPressed: () async {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: 'ahmad@garbagecan.pk', password: 'TUApp2021!');
                    if (user != null) {
                      Navigator.pushNamed(context, '/admin');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
