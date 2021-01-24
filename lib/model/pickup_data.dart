import 'package:flutter/foundation.dart';

class PickupData extends ChangeNotifier {
  Map<String, List<Map<String, dynamic>>> _pickupData = {};

  dynamic get pickupData {
    return _pickupData;
  }

  void addPickup(
      {String uid,
      String email,
      String name,
      String address,
      String phoneNumber,
      String date,
      String time,
      List<String> selectedItems}) {
    if (_pickupData[uid] != null) {
      _pickupData[uid].add({
        'email': email,
        'name': name,
        'address': address,
        'phone': phoneNumber,
        'date': date,
        'time': time,
        'items': selectedItems,
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
        }
      ];
    }
  }
}
