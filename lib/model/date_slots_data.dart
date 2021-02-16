import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:garbagecan/model/date_slots.dart';
import 'package:intl/intl.dart';

class DateSlotsData extends ChangeNotifier {
  List<TimeSlot> timeSlots = [];

  DateSlotsData() {
    // Listen to changes
    FirebaseFirestore.instance
        .collection('pickups')
        .where('taken')
        .snapshots()
        .listen((snapshot) {
      timeSlots = snapshot.docs.map((doc) {
        if (!doc.data().containsKey('time')) print(doc.id);
        final datetime = doc['time'].toDate();
        return TimeSlot(doc.id, datetime, isBlocked: doc['taken']);
      }).toList();
      timeSlots.sort((a, b) => a.dateTime.compareTo(b.dateTime));

      notifyListeners();
    });
  }

  Map<DateTime, List<TimeSlot>> events() {
    final Map<DateTime, List<TimeSlot>> events = {};
    for (final slot in timeSlots) {
      if (slot.isBlocked) continue;
      if (events.containsKey(slot.date))
        events[slot.date].add(slot);
      else
        events[slot.date] = [slot];
    }

    return events;
  }

  void selectDateSlot(TimeSlot slot) {
    slot.toggleSelected();
    notifyListeners();
  }

  Future<void> addDateSlots(
      {String beginDateString,
      String endDateString,
      String startTimeString,
      String endTimeString}) {
    DateTime beginDate = DateTime.parse(beginDateString);
    DateTime endDate = DateTime.parse(endDateString);
    DateTime startTime = DateFormat.Hm().parse(startTimeString);
    DateTime endTime = DateFormat.Hm().parse(endTimeString);

    final minutesDuration = 30;

    final batch = FirebaseFirestore.instance.batch();

    for (var i = 0; i <= endDate.difference(beginDate).inDays; i++) {
      for (var j = 0;
          j <= endTime.difference(startTime).inMinutes;
          j = j + minutesDuration) {
        batch.set(
          FirebaseFirestore.instance.collection('pickups').doc(),
          {
            'taken': false,
            'time_range': minutesDuration * 60000,
            'time': Timestamp.fromDate(DateTime(
              beginDate.year,
              beginDate.month,
              beginDate.day + i,
              startTime.hour,
              startTime.minute + j,
            )),
          },
        );
      }
    }

    return batch.commit();
  }

  Future<void> addDateSlotsWeekday(
      {int weekday,
      int dayNumber,
      int timeRange,
      String startTimeString,
      String endTimeString}) {
    DateTime startTime = DateFormat.Hm().parse(startTimeString);
    DateTime endTime = DateFormat.Hm().parse(endTimeString);

    final batch = FirebaseFirestore.instance.batch();

    List<DateTime> weekdays = getWeekdays(weekday, dayNumber);
    for (var wday in weekdays) {
      for (var j = 0;
          j <= endTime.difference(startTime).inMinutes;
          j = j + timeRange) {
        batch.set(
          FirebaseFirestore.instance.collection('pickups').doc(),
          {
            'taken': false,
            'time_range': timeRange * 60000,
            'time': Timestamp.fromDate(DateTime(
              wday.year,
              wday.month,
              wday.day,
              startTime.hour,
              startTime.minute + j,
            )),
          },
        );
      }
    }

    return batch.commit();
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

  TimeSlot getSelectedTime(DateTime selectedDate) {
    final List<TimeSlot> _selectedDateSlots =
        getSelectedTimeSlots(selectedDate);

    if (_selectedDateSlots == null || _selectedDateSlots.length == 0) {
      return null;
    } else {
      return _selectedDateSlots[0];
    }
  }

  List<TimeSlot> getUnblockedDateSlots(DateTime selectedDate) => timeSlots
      .where((s) =>
          !s.isBlocked &&
          s.dateTime.year == selectedDate.year &&
          s.dateTime.month == selectedDate.month &&
          s.dateTime.day == selectedDate.day)
      .toList();

  List<TimeSlot> getSelectedTimeSlots(DateTime selectedDate) => timeSlots
      .where((s) =>
          s.isSelected &&
          s.dateTime.year == selectedDate.year &&
          s.dateTime.month == selectedDate.month &&
          s.dateTime.day == selectedDate.day)
      .toList();
}
