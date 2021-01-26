import 'package:flutter/material.dart';
import 'package:garbagecan/components/tiles/pickup_tile.dart';
import 'package:garbagecan/model/pickup_data.dart';
import 'package:provider/provider.dart';

class PickupTileView extends StatelessWidget {
  final userID;

  PickupTileView({this.userID});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Consumer<PickupData>(
        builder: (context, pData, child) {
          return ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final pickup = pData.getActivePickups(userID)[index];
              return PickupTile(
                dateText: pickup['date'],
                timeText: pickup['time'].dateText,
              );
            },
            itemCount: pData.getActivePickups(userID) == null
                ? 0
                : pData.getActivePickups(userID).length,
          );
        },
      ),
    );
  }
}
