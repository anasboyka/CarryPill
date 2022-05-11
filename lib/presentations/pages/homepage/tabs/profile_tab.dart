import '../../../../constants/constant_widget.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Tab'),
      ),
      body: Center(
        child: Text(
          'Profile Tab TBD',
          style: kwstyleHeader35,
        ),
      ),
    );
  }
}
