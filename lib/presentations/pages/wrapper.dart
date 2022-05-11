import 'authenticate/authenticate.dart';
import 'homepage/homepage.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  Wrapper({Key? key}) : super(key: key);
  bool alreadyLogin = true;
  @override
  Widget build(BuildContext context) {
    if (alreadyLogin) {
      return const HomePage(
        title: "homepage TBD",
      );
    } else {
      return const Authenticate();
    }
  }
}
