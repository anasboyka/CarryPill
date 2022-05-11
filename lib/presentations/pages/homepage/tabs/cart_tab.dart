import '../../../../constants/constant_widget.dart';
import 'package:flutter/material.dart';

class CartTab extends StatefulWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  _CartTabState createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Tab'),
      ),
      body: Center(
        child: Text(
          'Cart Tab TBD',
          style: kwstyleHeader35,
        ),
      ),
    );
  }
}
