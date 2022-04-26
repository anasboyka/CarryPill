import 'package:carrypill/constants/constant_color.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  Login({Key? key, required this.toggleView}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page TBD'),
      ),
      body: Container(
        child: Center(
          child: MaterialButton(
            color: kPrimary,
            child: Text('Go to register page'),
            onPressed: () {
              widget.toggleView();
            },
          ),
        ),
      ),
    );
  }
}
