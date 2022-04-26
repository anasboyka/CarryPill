import 'package:carrypill/constants/constant_color.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Page TBD'),
      ),
      body: Container(
        child: Center(
            child: MaterialButton(
          color: kPrimary,
          child: Text('Go to register page'),
          onPressed: () {
            widget.toggleView();
          },
        )),
      ),
    );
  }
}
