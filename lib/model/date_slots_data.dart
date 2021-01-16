import 'package:garbagecan/model/date_slots.dart';
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
      DateSlots(dateText: '09:00'),
      DateSlots(dateText: '09:00'),
      DateSlots(dateText: '09:00'),
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

  void addDateSlots(
      {String beginDateString,
      String endDateString,
      String startTimeString,
      String endTimeString}) {
    DateTime beginDate = DateTime.parse(beginDateString);
    DateTime endDate = DateTime.parse(endDateString);
    DateTime startTime = DateFormat.Hm().parse(startTimeString);
    DateTime endTime = DateFormat.Hm().parse(endTimeString);

    for (var i = 0; i <= endDate.difference(beginDate).inDays; i++) {
      List<DateSlots> dateSlots = [];

      for (var j = 0;
          j <= endTime.difference(startTime).inMinutes;
          j = j + 30) {
        dateSlots.add(DateSlots(
            dateText: DateFormat.Hm().format(DateTime(
                startTime.year,
                startTime.month,
                startTime.day,
                startTime.hour,
                startTime.minute + j))));
      }

      _dateSlots[DateTime(beginDate.year, beginDate.month, beginDate.day + i)] =
          dateSlots;
    }
    notifyListeners();
  }
}
