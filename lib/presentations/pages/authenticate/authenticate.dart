import 'package:carrypill/presentations/pages/authenticate/login.dart';
import 'package:carrypill/presentations/pages/authenticate/register.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showLoginPage = true;

  void toggleView() {
    setState(() => showLoginPage = !showLoginPage);
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return Login(
        toggleView: toggleView,
      );
    } else {
      return Register(
        toggleView: toggleView,
      );
    }
  }
}
