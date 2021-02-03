import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:garbagecan/model/item.dart';

class ItemData extends ChangeNotifier {
  List<Item> _items = [];

  ItemData() {
    // Listen to changes
    FirebaseFirestore.instance
        .collection('trashItems')
        .snapshots()
        .listen((snapshot) {
      print('${snapshot.docs.length}');
      _items = snapshot.docs.map((doc) => Item(doc.id, doc.data())).toList();
      notifyListeners();
    });
  }

  UnmodifiableListView<Item> get items {
    return UnmodifiableListView<Item>(_items);
  }

  void updateCheckbox(Item item) {
    item.toogleCheckbox();
    notifyListeners();
  }

  void uncheckItems() {
    for (Item item in _items) {
      if (item.isChecked == true) {
        item.toogleCheckbox();
      }
    }
    notifyListeners();
  }

  List<Item> getSelectedItems() => _items.where((i) => i.isChecked).toList();

  void updateTrashItemValues(Map<String, int> newValues) {
    newValues.forEach((key, value) {
      FirebaseFirestore.instance
          .collection('trashItems')
          .doc(key)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          if (value != documentSnapshot.data()['value']) {
            FirebaseFirestore.instance
                .collection('trashItems')
                .doc(key)
                .update({'value': value});
          }
        } else {
          print('Document does not exist on the database');
        }
      });
    });
  }
}
