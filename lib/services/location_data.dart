import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

class LocationData {
  double latitude;
  double longitude;

  void getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    latitude = position.latitude;
    longitude = position.longitude;
  }

  Future<String> getAddressForCoordinates() async {
    final coordinates = Coordinates(latitude, longitude);
    var addresses =
        //Geocoder package has a bug, so that we would have to use a google maps API key to get the address from the coordinates
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    print(addresses[0].addressLine);
    return addresses[0].addressLine;
  }

  Future<Coordinates> getCoordinatesFromAddress(String query) async {
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    return addresses.first.coordinates;
  }
}
