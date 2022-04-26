import 'package:carrypill/presentations/pages/authenticate/authenticate.dart';
import 'package:carrypill/presentations/pages/homepage/homepage.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  Wrapper({Key? key}) : super(key: key);
  bool alreadyLogin = false;
  @override
  Widget build(BuildContext context) {
    if (alreadyLogin) {
      return HomePage(
        title: "homepage TBD",
      );
    } else {
      return Authenticate();
    }
  }
}
