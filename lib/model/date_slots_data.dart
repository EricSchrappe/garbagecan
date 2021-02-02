import 'package:flutter/foundation.dart';
import 'package:garbagecan/model/date_slots.dart';
import 'package:intl/intl.dart';

class DateSlotsData extends ChangeNotifier {
  // TODO: Update to data from API
  Map<DateTime, List<TimeSlot>> _dateSlots = {
    DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2021, 2, 9))): [
      TimeSlot(7),
      TimeSlot(7, 30),
      TimeSlot(8),
      TimeSlot(8, 30),
      TimeSlot(9),
      TimeSlot(9, 30),
      TimeSlot(10),
    ],
    DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2021, 2, 15))): [
      TimeSlot(7),
      TimeSlot(7, 30),
      TimeSlot(8),
      TimeSlot(8, 30),
      TimeSlot(9),
    ]
  };

  Map<DateTime, List<TimeSlot>> get dateSlots {
    return _dateSlots;
  }

  void selectDateSlot(TimeSlot slot) {
    slot.toggleSelected();
    notifyListeners();
  }

  void blockDateSlot(TimeSlot slot) {
    slot.toggleBlocked();
    notifyListeners();
  }

  void unblockDateSlot(TimeSlot slot) {
    slot.toggleUnblocked();
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
      List<TimeSlot> dateSlots = [];

      for (var j = 0;
          j <= endTime.difference(startTime).inMinutes;
          j = j + 30) {
        dateSlots.add(TimeSlot(
          startTime.hour,
          startTime.minute + j,
        ));
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
      List<TimeSlot> dateSlots = [];

      for (var j = 0;
          j <= endTime.difference(startTime).inMinutes;
          j = j + 30) {
        dateSlots.add(TimeSlot(
          startTime.hour,
          startTime.minute + j,
        ));
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

  DateTime getSelectedTime(DateTime selectedDate) {
    final List<TimeSlot> _selectedDateSlots = _dateSlots[selectedDate];

    if (_selectedDateSlots == null || _selectedDateSlots.length == 0) {
      return null;
    } else {
      for (TimeSlot slot in _selectedDateSlots)
        if (slot.isSelected) {
          notifyListeners();
          return DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            slot.hour,
            slot.minute,
          );
        }
      return null;
    }
  }

  List<TimeSlot> getUnblockedDateSlots(DateTime selectedDate) =>
      _dateSlots[selectedDate].where((s) => !s.isBlocked).toList();

  List<TimeSlot> getSelectedTimeSlot(DateTime selectedDate) =>
      _dateSlots[selectedDate].where((s) => s.isSelected).toList();
}
