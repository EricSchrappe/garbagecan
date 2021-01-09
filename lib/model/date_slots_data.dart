import 'package:garbagecan/model/date_slots.dart';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class DateSlotsData extends ChangeNotifier {
  // TODO: Update to data from API
  Map<DateTime, List<DateSlots>> _dateSlots = {
    DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2021, 1, 9))): [
      DateSlots(dateText: '07:00'),
      DateSlots(dateText: '07:30'),
      DateSlots(dateText: '08:00'),
      DateSlots(dateText: '08:30'),
      DateSlots(dateText: '09:00'),
    ],
    DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2021, 1, 15))): [
      DateSlots(dateText: '07:00'),
      DateSlots(dateText: '07:30'),
      DateSlots(dateText: '08:00'),
      DateSlots(dateText: '08:30'),
      DateSlots(dateText: '09:00'),
    ]
  };

  dynamic get dateSlots {
    return _dateSlots;
  }

  void selectDateSlot(DateSlots slot) {
    slot.toogleSelected();
    notifyListeners();
  }
}
