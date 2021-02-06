import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:garbagecan/api.dart';
import 'package:garbagecan/model/date_slots.dart';
import 'package:garbagecan/model/item.dart';

class Pickup {
  String id;
  String uid;
  String email;
  String name;
  String address;
  String phoneNumber;
  TimeSlot time;
  List<Item> items;
  GeoPoint gps;
  bool deleted = false;

  Pickup({
    @required this.id,
    @required this.uid,
    @required this.email,
    @required this.name,
    @required this.address,
    @required this.phoneNumber,
    @required this.time,
    @required this.items,
    @required this.gps,
    this.deleted = false,
  });

  Pickup.fromDocument(this.id, Map<String, dynamic> data, [this.items])
      : uid = data['uid'],
        email = data['email'],
        name = data['name'],
        address = data['address'],
        phoneNumber = data['phoneNumber'],
        time = TimeSlot(id, data['time'].toDate()),
        gps = data['gps'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'email': email,
      'name': name,
      'address': address,
      'phoneNumber': phoneNumber,
      'time': time.dateTime.toIso8601String(),
      'trashItems': items.map((i) => i.toJson()).toList(),
      'gps': gps.toString(),
    };
  }
}

class PickupData extends ChangeNotifier {
  Map<String, List<Pickup>> _pickups = {};

  Map<String, List<Pickup>> get pickupData {
    return _pickups;
  }

  PickupData() {
    // Listen to changes
    FirebaseFirestore.instance
        .collection('pickups')
        .where('taken', isEqualTo: true)
        .snapshots()
        .listen((snapshot) async {
      _pickups.clear();
      for (final doc in snapshot.docs) {
        List<Item> items = [];
        if (doc.data().containsKey('trashItems')) {
          final trashItems = List<DocumentReference>.from(doc['trashItems']);
          items = await Future.wait(trashItems.map(
            (DocumentReference r) async => Item(r.id, (await r.get()).data()),
          ));
        }

        final pickup = Pickup.fromDocument(doc.id, doc.data(), items);

        if (_pickups.containsKey(doc['uid']))
          _pickups[doc['uid']].add(pickup);
        else
          _pickups[doc['uid']] = [pickup];
      }
      notifyListeners();
    });
  }

  void addPickup(Pickup pickup) {
    requestPickup(pickup);
    // TODO: this should be removed when pickup requests work on the server
    if (_pickups[pickup.uid] != null) {
      _pickups[pickup.uid].add(pickup);
    } else {
      _pickups[pickup.uid] = [pickup];
    }
  }

  List<Pickup> getActivePickups(String uid) {
    List<Pickup> activePickup = [];

    if (_pickups[uid] == null) {
      return null;
    } else {
      for (var pickup in _pickups[uid]) {
        if (!pickup.deleted) {
          activePickup.add(pickup);
        }
      }
      return activePickup;
    }
  }
}
