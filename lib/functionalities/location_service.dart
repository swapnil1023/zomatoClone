import 'dart:async';

import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'local_data.dart';

class LocationService {
  var location = Location();
  LatLng _currentLocation;
  Future<LatLng> getLocation() async {
    try {
      var _userLocation = await location.getLocation();
      print('found location');
      _currentLocation = LatLng(_userLocation.latitude, _userLocation.longitude);
      LocalData().saveLocation(
          latitude: _userLocation.latitude, longitude: _userLocation.longitude);
      
    } catch (e) {
      print(e);
    }
    return _currentLocation;
  }

  Future<String> getAddress(LatLng loc) async {
    var address = await Geocoder.local
        .findAddressesFromCoordinates(Coordinates(loc.latitude, loc.longitude));
    return address.first.addressLine;
  }
}
