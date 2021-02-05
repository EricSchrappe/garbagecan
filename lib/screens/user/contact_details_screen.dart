import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garbagecan/services/location_data.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ContactDetails extends StatefulWidget {
  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _textController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool showSpinner = false;

  LocationData location = LocationData();

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
    location.getLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments;

    final selectedDate = args.values.first;

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
          child: Column(
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
                      'Please fill in your contact information',
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
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
                        'Name',
                        style: TextStyle(
                          color: Color(0xFF444444),
                          fontSize: 18.0,
                        ),
                      ),
                      TextField(
                        controller: _nameController,
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
                        ),
                        onSubmitted: (name) {
                          _nameController.text = name;
                        },
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        'Email',
                        style: TextStyle(
                          color: Color(0xFF444444),
                          fontSize: 18.0,
                        ),
                      ),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
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
                        ),
                        onSubmitted: (email) {
                          _emailController.text = email;
                        },
                      ),
                      SizedBox(
                        height: 15.0,
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
                            flex: 10,
                            child: TextField(
                              controller: _textController,
                              readOnly:
                                  _textController.text != null ? true : false,
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
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.clear,
                                    color: Color(0xFF3A6ED4),
                                  ),
                                  onPressed: () => _textController.clear(),
                                ),
                              ),
                              onSubmitted: (address) {
                                _textController.text = address;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
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
                                setState(() {
                                  showSpinner = true;
                                });
                                location
                                    .getAddressForCoordinates()
                                    .then((String address) {
                                  setState(() {
                                    _textController.text = address;
                                    showSpinner = false;
                                  });
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        'Phone Number',
                        style: TextStyle(
                          color: Color(0xFF444444),
                          fontSize: 18.0,
                        ),
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: _phoneController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
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
                        ),
                        onSubmitted: (phoneNumber) {
                          _phoneController.text = phoneNumber;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  'Go to Trash Items',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24.0),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/selecttrash',
                                      arguments: {
                                        'name': _nameController.text,
                                        'email': _emailController.text,
                                        'phone': _phoneController.text,
                                        'address': _textController.text,
                                        'selectedDate': selectedDate,
                                      });
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
      ),
    );
  }
}
