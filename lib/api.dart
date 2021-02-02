import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:garbagecan/model/pickup_data.dart';
import 'package:http/http.dart' as http;

const endpoint = "http://localhost:3000";

Future<void> requestPickup(Pickup pickup) async {
  final pickupJson = pickup.toJson();
  debugPrint(pickupJson.toString());
  final body = json.encode({
    'cmd': 0,
    ...pickupJson,
  });
  final res = await http.post('$endpoint/pickup', body: body);
  debugPrint(res.body);
}
