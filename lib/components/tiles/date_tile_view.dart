import 'package:flutter/material.dart';
import 'package:garbagecan/model/date_slots_data.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'date_tile.dart';

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
              final slot =
                  dateSlotsData.getUnblockedDateSlots(selectedDate)[index];
              return DateTile(
                dateText: DateFormat.Hm().format(slot.dateTime),
                isSelected: slot.isSelected,
                selectedCallback: () {
                  dateSlotsData.selectDateSlot(slot);
                },
              );
            },
            itemCount: dateSlotsData.getUnblockedDateSlots(selectedDate).length,
          );
        },
      ),
    );
  }
}
