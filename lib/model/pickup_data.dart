import 'package:flutter/foundation.dart';
import 'package:garbagecan/model/date_slots.dart';

class PickupData extends ChangeNotifier {
  Map<String, List<Map<String, dynamic>>> _pickupData = {};

  dynamic get pickupData {
    return _pickupData;
  }

  void addPickup({
    String uid,
    String email,
    String name,
    String address,
    String phoneNumber,
    String date,
    DateSlots time,
    List<String> selectedItems,
    bool deleted = false,
  }) {
    if (_pickupData[uid] != null) {
      _pickupData[uid].add({
        'email': email,
        'name': name,
        'address': address,
        'phone': phoneNumber,
        'date': date,
        'time': time,
        'items': selectedItems,
        'deleted': deleted,
      });
    } else {
      _pickupData[uid] = [
        {
          'email': email,
          'name': name,
          'address': address,
          'phone': phoneNumber,
          'date': date,
          'time': time,
          'items': selectedItems,
          'deleted': deleted,
        }
      ];
    }
  }

  dynamic getActivePickups(String uid) {
    List<Map<String, dynamic>> activePickup = [];

    if (_pickupData[uid] == null) {
      return 0;
    } else {
      for (var pickup in _pickupData[uid]) {
        if (pickup['deleted'] == false) {
          activePickup.add(pickup);
        }
      }
      return activePickup;
    }
  }
}
