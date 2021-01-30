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

  void blockDateSlot(DateSlots slot) {
    slot.toogleBlocked();
    notifyListeners();
  }

  void unblockDateSlot(DateSlots slot) {
    slot.toogleUnblocked();
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

  void addDateSlotsWeekday(
      {int weekday,
      int dayNumber,
      String startTimeString,
      String endTimeString}) {
    DateTime startTime = DateFormat.Hm().parse(startTimeString);
    DateTime endTime = DateFormat.Hm().parse(endTimeString);

    List<DateTime> weekdays = getWeekdays(weekday, dayNumber);
    for (var wday in weekdays) {
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
      _dateSlots[DateTime.parse(DateFormat('yyyy-MM-dd').format(wday))] =
          dateSlots;
    }
    notifyListeners();
  }

  List<DateTime> getWeekdays(int weekday, int dayNumber) {
    List<DateTime> dates = [];

    int wday = weekday;
    DateTime now = DateTime.now();
    for (var i = 1; i <= dayNumber; i++) {
      if (now.weekday != wday) {
        while (now.weekday != wday) {
          now = now.add(
            Duration(days: 1),
          );
        }
        dates.add(now);
      } else if (now.weekday == wday) {
        now = now.add(
          Duration(days: 1),
        );
        i--;
      }
    }
    return dates;
  }

  dynamic getSelectedTime(DateTime selectedDate) {
    List<dynamic> dateSelectedTime = [
      DateFormat('yyyy-MM-dd').format(selectedDate)
    ];

    final List<DateSlots> _selectedDateSlots = _dateSlots[selectedDate];

    if (_selectedDateSlots == null) {
      return 0;
    } else {
      for (DateSlots slot in _selectedDateSlots) {
        if (slot.isSelected) {
          dateSelectedTime.add(slot);
        }
      }

      notifyListeners();
      return dateSelectedTime;
    }
  }

  dynamic getUnblockedDateSlots(DateTime selectedDate) {
    List<DateSlots> unblockedSlots = [];

    for (var slot in _dateSlots[selectedDate]) {
      if (slot.isBlocked != true) {
        unblockedSlots.add(slot);
      }
    }
    return unblockedSlots;
  }

  dynamic getSelectedTimeSlot(DateTime selectedDate) {
    List<DateSlots> slots = [];

    for (var slot in _dateSlots[selectedDate]) {
      if (slot.isSelected) {
        slots.add(slot);
      }
    }
    return slots;
  }
}
