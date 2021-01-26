import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garbagecan/components/tiles/item_tile_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:garbagecan/model/date_slots_data.dart';
import 'package:garbagecan/model/pickup_data.dart';
import 'package:garbagecan/model/item_data.dart';
import 'package:provider/provider.dart';

class ContactDetails extends StatefulWidget {
  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

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
    final Map args = ModalRoute.of(context).settings.arguments;

    final selectedDate = args.values.first;
    final address = args.values.last;
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
                        isDense: true,
                        contentPadding: EdgeInsets.all(8.0),
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
                        isDense: true,
                        contentPadding: EdgeInsets.all(8.0),
                      ),
                      onSubmitted: (email) {
                        _emailController.text = email;
                      },
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
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                      onSubmitted: (phoneNumber) {
                        _phoneController.text = phoneNumber;
                      },
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      'Select your items',
                      style: TextStyle(
                        color: Color(0xFF444444),
                        fontSize: 18.0,
                      ),
                    ),
                    Expanded(flex: 8, child: ItemTileView()),
                    Expanded(
                      flex: 4,
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
                                Provider.of<PickupData>(context, listen: false)
                                    .addPickup(
                                  uid: loggedInUser.uid,
                                  date: Provider.of<DateSlotsData>(context,
                                          listen: false)
                                      .getSelectedTime(selectedDate)[0],
                                  address: address,
                                  email: _emailController.text,
                                  name: _nameController.text,
                                  phoneNumber: _phoneController.text,
                                  time: Provider.of<DateSlotsData>(context,
                                          listen: false)
                                      .getSelectedTime(selectedDate)
                                      .last,
                                  selectedItems: Provider.of<ItemData>(context,
                                          listen: false)
                                      .getSelectedItems(),
                                );
                                print(Provider.of<PickupData>(context,
                                        listen: false)
                                    .pickupData
                                    .length);
                                print(Provider.of<PickupData>(context,
                                        listen: false)
                                    .pickupData);
                                Provider.of<ItemData>(context, listen: false)
                                    .uncheckItems();
                                Provider.of<DateSlotsData>(context,
                                        listen: false)
                                    .blockDateSlot(Provider.of<DateSlotsData>(
                                            context,
                                            listen: false)
                                        .getSelectedTimeSlot(selectedDate)
                                        .last);
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
