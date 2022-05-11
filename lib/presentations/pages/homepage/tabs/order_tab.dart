import '../../../../constants/constant_widget.dart';
import 'package:flutter/material.dart';

class OrderTab extends StatefulWidget {
  const OrderTab({Key? key}) : super(key: key);

  @override
  _OrderTabState createState() => _OrderTabState();
}

class _OrderTabState extends State<OrderTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OrderTab'),
      ),
      body: Center(
        child: Text(
          'Order Tab TBD',
          style: kwstyleHeader35,
        ),
      ),
    );
  }
}
