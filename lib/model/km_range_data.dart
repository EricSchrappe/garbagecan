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
      _price.clear();
      _radius.clear();
      snapshot.data().forEach((key, value) {
        if (key == 'price') {
          for (num ele in value) {
            _price.add(ele.toDouble());
          }
        }
        if (key == 'radius') {
          for (num ele in value) {
            _radius.add(ele.toDouble());
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

  void updateKmRange(int index, double newPrice, double newRadius) {
    FirebaseFirestore.instance
        .collection('admin')
        .doc('km_ranges')
        .get()
        .then((snapshot) {
      final prices = snapshot['price'];
      prices[index] = newPrice;
      final radii = snapshot['radius'];
      radii[index] = newRadius;
      FirebaseFirestore.instance.collection('admin').doc('km_ranges').update({
        'price': prices,
        'radius': radii,
      });
    });
  }
}
