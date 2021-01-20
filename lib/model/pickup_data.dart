import 'package:flutter/foundation.dart';
import 'item.dart';

class PickupData extends ChangeNotifier {
  Map<String, Map<String, dynamic>> _pickupData;

  dynamic get pickupData {
    return _pickupData;
  }

  void addPickup(String uid, String email, int phoneNumber, String date,
      String time, List<Item> selectedItems) {
    _pickupData[uid] = {
      'email': email,
      'phone': phoneNumber,
      'date': date,
      'time': time,
      'items': selectedItems,
    };
  }
}
