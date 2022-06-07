import 'package:carrypill/presentations/custom_widgets/error_page.dart';
import 'package:carrypill/presentations/pages/authenticate/authenticate.dart';
import 'package:carrypill/presentations/pages/homepage/tabs/subprofile/profile_info.dart';

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
        return CupertinoPageRoute(builder: (_) => Wrapper());
      case '/requestdelivery':
        return CupertinoPageRoute(builder: (_) => const RequestDelivery());
      case '/profileinfo':
        return CupertinoPageRoute(
            builder: (_) => ProfileInfo(
                  arg: args as Map<String, dynamic>,
                ));
      default:
        return CupertinoPageRoute(builder: (_) => const ErrorPage());
    }
  }
}
