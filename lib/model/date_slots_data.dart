import 'package:garbagecan/model/date_slots.dart';
import 'dart:collection';
import 'package:flutter/foundation.dart';

class DateSlotsData extends ChangeNotifier {
  // TODO: Update to data from API
  List<DateSlots> _dateSlots = [
    DateSlots(dateText: '07:00'),
    DateSlots(dateText: '07:30'),
    DateSlots(dateText: '08:00'),
    DateSlots(dateText: '08:30'),
    DateSlots(dateText: '09:00'),
  ];

  UnmodifiableListView get dateSlots {
    return UnmodifiableListView(_dateSlots);
  }

  void selectDateSlot(DateSlots slot) {
    slot.toogleSelected();
    notifyListeners();
  }
}
