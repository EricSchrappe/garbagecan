import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garbagecan/model/km_range_data.dart';
import 'package:provider/provider.dart';

class EditKmRangeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final index = ModalRoute.of(context).settings.arguments;
    final TextEditingController _controllerPrice = TextEditingController();
    final TextEditingController _controllerRadius = TextEditingController();

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
                    'Edit Radius & Price',
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
                      'Radius',
                      style: TextStyle(
                        color: Color(0xFF444444),
                        fontSize: 18.0,
                      ),
                    ),
                    TextField(
                      controller: _controllerRadius
                        ..text = Provider.of<KmRangeData>(context)
                            .radius[index]
                            .toString(),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
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
                      onSubmitted: (value) {
                        _controllerRadius.text = value;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Price',
                      style: TextStyle(
                        color: Color(0xFF444444),
                        fontSize: 18.0,
                      ),
                    ),
                    TextField(
                      controller: _controllerPrice
                        ..text = Provider.of<KmRangeData>(context)
                            .price[index]
                            .toString(),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
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
                      onSubmitted: (value) {
                        _controllerPrice.text = value;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RaisedButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50.0, vertical: 10.0),
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
                                horizontal: 50.0, vertical: 10.0),
                            child: Text(
                              'Select',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 24.0),
                            ),
                            color: Color(0xFF3A6ED4),
                            onPressed: () {
                              Provider.of<KmRangeData>(context, listen: false)
                                  .updateKmRange(
                                index,
                                double.parse(_controllerPrice.text),
                                double.parse(_controllerPrice.text),
                              );
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    )
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
