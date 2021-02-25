import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garbagecan/model/item_data.dart';
import 'package:provider/provider.dart';

class TrashItemsScreen extends StatelessWidget {
  final Map<String, int> newValues = {};
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
                    'Adjust the trash item prices if necessary',
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
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.42,
                      child: Consumer<ItemData>(
                        builder: (context, itemData, child) {
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final item = itemData.items[index];

                              return ListTile(
                                title: Text(
                                  item.name,
                                  style: TextStyle(
                                    color: Color(0xFF444444),
                                    fontSize: 18.0,
                                  ),
                                ),
                                subtitle: Text(
                                  'The current value is ${item.value} Rs. per ${item.unit}',
                                  style: TextStyle(
                                    color: Color(0xFF444444),
                                    fontSize: 12.0,
                                  ),
                                ),
                                trailing: SizedBox(
                                  width: 80.0,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: TextField(
                                          textAlign: TextAlign.center,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
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
                                            isDense: true,
                                            contentPadding: EdgeInsets.all(8.0),
                                          ),
                                          onChanged: (value) {
                                            if (value.length > 0)
                                              newValues[item.id] =
                                                  int.parse(value);
                                            else
                                              newValues.remove(item.id);
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(' /${item.unit}'),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: itemData.items.length,
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        color: Color(0xFF3A6ED4),
                        child: Text(
                          'Adjust items',
                          style: TextStyle(color: Colors.white, fontSize: 24.0),
                        ),
                        onPressed: () {
                          Provider.of<ItemData>(context, listen: false)
                              .updateTrashItemValues(newValues);
                          newValues.clear();
                          Navigator.pop(context);
                        },
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
