import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garbagecan/model/km_range_data.dart';
import 'package:garbagecan/services/location_data.dart';
import 'package:geocoder/geocoder.dart';
import 'package:provider/provider.dart';

class HeadquarterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controllerText = TextEditingController();
    final LocationData location = LocationData();
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
                    'Here you can set a new headquarters and adjust the Km ranges',
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
                      'Address headquarters',
                      style: TextStyle(
                        color: Color(0xFF444444),
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      controller: _controllerText
                        ..text = 'Straße des 17. Juni 135, 10623 Berlin',
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
                        helperText: 'Format: Street Number, Postal code City',
                      ),
                      onSubmitted: (name) async {
                        _controllerText.text = name;
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                        ),
                        color: Color(0xFF3A6ED4),
                        onPressed: () async {
                          Coordinates coord = await location
                              .getCoordinatesFromAddress(_controllerText.text);

                          DocumentReference document = _firestore
                              .collection('admin')
                              .doc('gps_headquarters');

                          document.update({
                            'gps': GeoPoint(coord.latitude, coord.longitude),
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 10.0),
                            decoration: BoxDecoration(
                                color: Color(0xFF3A6ED4),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Radius',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.0),
                                ),
                                Text(
                                  'Price',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.0),
                                ),
                                Text(
                                  'Edit',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.0),
                                ),
                                Text(
                                  'Delete',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.0),
                                ),
                              ],
                            ),
                          ),
                          Consumer<KmRangeData>(
                            builder: (context, kmData, child) {
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final price = kmData.price[index];
                                  final radius = kmData.radius[index];

                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '$radius',
                                          style: TextStyle(fontSize: 18.0),
                                        ),
                                        Text(
                                          '$price',
                                          style: TextStyle(fontSize: 18.0),
                                        ),
                                        GestureDetector(
                                          child: Icon(Icons.edit),
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/edit',
                                                arguments: index);
                                          },
                                        ),
                                        GestureDetector(
                                          child: Icon(Icons.delete_forever),
                                          onTap: () {},
                                        )
                                      ],
                                    ),
                                  );
                                },
                                itemCount: kmData.price.length,
                              );
                            },
                          ),
                        ],
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
