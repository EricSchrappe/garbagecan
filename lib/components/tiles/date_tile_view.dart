import 'package:flutter/material.dart';
import 'date_tile.dart';
import 'package:garbagecan/model/date_slots_data.dart';
import 'package:provider/provider.dart';

class DateListTileView extends StatelessWidget {
  final selectedDate;

  DateListTileView({this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Consumer<DateSlotsData>(
        builder: (context, dateSlotsData, child) {
          return ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final dateSlot = dateSlotsData.dateSlots[selectedDate][index];
              return DateTile(
                dateText: dateSlot.dateText,
                isSelected: dateSlot.isSelected,
                selectedCallback: () {
                  dateSlotsData.selectDateSlot(dateSlot);
                },
              );
            },
            itemCount: dateSlotsData.dateSlots[selectedDate].length,
          );
        },
      ),
    );
  }
}