import 'package:flutter/material.dart';
import 'date_tile.dart';
import 'package:garbagecan/model/date_slots_data.dart';
import 'package:provider/provider.dart';

class DateListTileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DateSlotsData>(
      builder: (context, dateSlotsData, child) {
        return ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final dateSlot = dateSlotsData.dateSlots[index];
            return Center(
              child: DateTile(
                dateText: dateSlot.dateText,
                isSelected: dateSlot.isSelected,
                selectedCallback: (dateSlotState) {
                  dateSlotsData.selectDateSlot(dateSlot);
                },
              ),
            );
          },
          itemCount: dateSlotsData.dateSlots.length,
        );
      },
    );
  }
}
