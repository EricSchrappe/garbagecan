import 'package:garbagecan/model/item.dart';
import 'dart:collection';
import 'package:flutter/foundation.dart';

class ItemData extends ChangeNotifier {
  List<Item> _items = [
    Item(name: 'Paper'),
    Item(name: 'Cardboard Box'),
    Item(name: 'Cardboard Packet'),
    Item(name: 'Newspaper (Urdu)'),
    Item(name: 'Newspaper (English'),
    Item(name: 'Aluminum Can'),
    Item(name: 'Copper'),
    Item(name: 'Tin'),
    Item(name: 'Iron'),
    Item(name: 'Plastic Bottles (PET)'),
    Item(name: 'Plastic (Other)')
  ];

  UnmodifiableListView get items {
    return UnmodifiableListView(_items);
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

  List<String> getSelectedItems() {
    List<String> selectedItems = [];

    for (Item item in _items) {
      if (item.isChecked) {
        selectedItems.add(item.name);
      }
    }
    return selectedItems;
  }
}
