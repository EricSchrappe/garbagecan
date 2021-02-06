import 'package:flutter/material.dart';
import 'package:garbagecan/model/pickup_data.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PickupOverviewScreen extends StatelessWidget {
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
                    'Here is an overview of all scheduled pickups',
                    style: TextStyle(
                      color: Color(0xFF444444),
                      fontSize: 22.0,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  height: MediaQuery.of(context).size.height * 0.42,
                  child: Consumer<PickupData>(
                    builder: (context, pdata, child) {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          final pickup = pdata.pickupData.values
                              .elementAt(index)
                              .elementAt(index);
                          return Card(
                            elevation: 5.0,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Email: ${pickup.email}',
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: 10.0, bottom: 10.0),
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        child: Text(
                                          'Address: ${pickup.address}',
                                          style: TextStyle(fontSize: 18.0),
                                        ),
                                      ),
                                      Text(
                                        'Phone: ${pickup.phoneNumber}',
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                      Divider(
                                        color: Color(0xFF3A6ED4),
                                        thickness: 2.0,
                                      ),
                                      Text(
                                        'Trash Items',
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.08,
                                        child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          itemBuilder: (context, index) {
                                            final trashItem =
                                                pickup.items[index];
                                            return Center(
                                              child: Text(
                                                trashItem.name,
                                              ),
                                            );
                                          },
                                          itemCount: pickup.items.length,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(Icons.event_note),
                                          Text(
                                            DateFormat('yyyy/MM/dd')
                                                .format(pickup.time.date),
                                            style: TextStyle(fontSize: 18.0),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(Icons.alarm),
                                          Text(
                                            DateFormat('HH:mm')
                                                .format(pickup.time.dateTime),
                                            style: TextStyle(fontSize: 18.0),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: pdata.pickupData.length,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
