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
    /*newValues.forEach((key, newValue) {
      FirebaseFirestore.instance
          .collection('trashItems')
          .doc(key)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          if (newValue != documentSnapshot.data()['value']) {
            documentSnapshot.data().update('value', (value) {
              value = newValue;
              print(value);
            });
          }
        } else {
          print('Document does not exist on the database');
        }
      });*/

    newValues.forEach((key, newValue) {
      FirebaseFirestore.instance
          .collection('trashItems')
          .snapshots()
          .forEach((element) {
        print(element.docs.map((e) {
          if (e.data()['value'] != newValue) {
            e.data().update('value', (value) {
              value = newValue;
              print(value);
            });
          }
        }));
      });
    });

    notifyListeners();
  }
}
