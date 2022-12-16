import 'dart:io';

import 'package:carrypill/data/dataproviders/map_provider/location_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class LocationRepo {
  Future<Position?> initPosition() async {
    final hasPermission = await _handlePermission();
    if (hasPermission is String) {
      return null;
    }
    if (hasPermission is bool && hasPermission == false) {
      return null;
    }
    Position? position = await LocationProvider().getLastLocation();
    if (position != null) {
      return position;
    } else {
      position = await LocationProvider().getCurrentLocation();
    }
    return position;
  }

  Future getCurrentLocation() async {
    final hasPermission = await _handlePermission();
    if (hasPermission is String) {
      return hasPermission;
    }
    if (!hasPermission) {
      return null;
    }
    return await LocationProvider().getLastLocation();
  }

  double calculateDistance(GeoPoint geoPoint1, GeoPoint geoPoint2) {
    return LocationProvider().calculateDistanceInKm(geoPoint1.latitude,
        geoPoint1.longitude, geoPoint2.latitude, geoPoint2.longitude);
  }

  double calculateDeliveryCharge(GeoPoint geoPoint1, GeoPoint geoPoint2) {
    double charge =
        10 + calculateDistance(geoPoint1, geoPoint2).roundToDouble();
    return charge;
  }

  double calculatePickupCharge() {
    double charge = 10;
    return charge;
  }

  Future<dynamic> _handlePermission() async {
    bool serviceEnabled = await LocationProvider().locationServiceStatus();
    if (!serviceEnabled) {
      return "Please enable your location";
    }

    // if (Platform.isAndroid) {
    LocationPermission permission = await LocationProvider().checkPermission();
    // print('checkpermission');
    if (permission == LocationPermission.denied) {
      permission = await GeolocatorPlatform.instance
          .requestPermission(); //await LocationProvider().requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return "Please give access to location permission";
      } else {
        return true;
      }
    }
    //}

    return true;
  }
}
