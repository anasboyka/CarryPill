import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ProviderLocation extends ChangeNotifier {
  Position? position;
  ProviderLocation({
    this.position,
  });
}
