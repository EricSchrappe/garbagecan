import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class KmRangeData extends ChangeNotifier {
  List<double> _price = [];
  List<double> _radius = [];

  KmRangeData() {
    FirebaseFirestore.instance
        .collection('admin')
        .doc('km_ranges')
        .snapshots()
        .listen((snapshot) {
      snapshot.data().forEach((key, value) {
        if (key == 'price') {
          for (var ele in value) {
            _price.add(double.parse(ele.toString()));
          }
        } else {
          for (var ele in value) {
            _radius.add(double.parse(ele.toString()));
          }
        }
      });
      notifyListeners();
    });
  }

  UnmodifiableListView<double> get price {
    return UnmodifiableListView<double>(_price);
  }

  UnmodifiableListView<double> get radius {
    return UnmodifiableListView<double>(_radius);
  }

  void updateKmRange(int index, double newPrice, double newRadius) {}
}
