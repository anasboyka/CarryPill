import 'presentations/pages/homepage/homepage.dart';
import 'presentations/pages/homepage/tabs/subhome/request_delivery.dart';
import 'presentations/pages/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(builder: (_) => RequestDelivery());
      default:
        return CupertinoPageRoute(
            builder: (_) => HomePage(title: 'Home page TBD'));
    }
  }
}
