import 'package:carrypill/presentations/pages/homepage/homepage.dart';
import 'package:carrypill/presentations/pages/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(builder: (_) => Wrapper());
      default:
        return CupertinoPageRoute(
            builder: (_) => HomePage(title: 'Home page TBD'));
    }
  }
}
