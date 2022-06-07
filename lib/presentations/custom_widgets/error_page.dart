import 'package:carrypill/constants/constant_color.dart';
import 'package:carrypill/constants/constant_widget.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: kcGreyLabel,
        child: const Center(
          child: Text(
            'Error navigating',
            style: kwstyleHeaderw35,
          ),
        ),
      ),
    );
  }
}
