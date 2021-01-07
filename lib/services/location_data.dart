import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

class LocationData {
  double _latitude;
  double _longitude;

  void getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    _latitude = position.latitude;
    _longitude = position.longitude;
  }

  Future<String> getAddressForCoordinates() async {
    final coordinates = Coordinates(_latitude, _longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    print(addresses[0].addressLine);
    return addresses[0].addressLine;
  }
}
