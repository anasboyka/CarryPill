import 'package:geolocator/geolocator.dart';
import 'dart:math';

class LocationProvider {
  GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
  Future<Position?> getLastLocation() async {
    return await Geolocator.getLastKnownPosition(
        forceAndroidLocationManager: true);
  }

  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<bool> locationServiceStatus() async {
    //GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
    return await geolocatorPlatform.isLocationServiceEnabled();
  }

  Future<LocationPermission> checkPermission() async {
    //GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
    return await geolocatorPlatform.checkPermission();
  }

  // Future<LocationPermission> requestPermission() async {
  //   //GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  //   return await geolocatorPlatform.requestPermission();
  // }

  double calculateDistanceInKm(
      double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
    //return in KM
  }

  // Future<bool> _handlePermission() async {
  //   GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   // Test if location services are enabled.
  //   serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.
  //     return false;
  //   }

  //   permission = await _geolocatorPlatform.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await _geolocatorPlatform.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.
  //       return false;
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.

  //     return false;
  //   }

  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.

  //   return true;
  // }
}
