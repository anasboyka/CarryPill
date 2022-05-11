import 'dart:io';

import '../../../constants/constant_color.dart';
import '../../../constants/constant_widget.dart';
import 'tabs/cart_tab.dart';
import 'tabs/home_tab.dart';
import 'tabs/order_tab.dart';
import 'tabs/profile_tab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final pages = [
    const HomeTab(),
    const OrderTab(),
    const CartTab(),
    const ProfileTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcBgHome1,
      body: IndexedStack(
        children: pages,
        index: currentIndex,
      ),
      bottomNavigationBar: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11.0),
            child: Container(
              height: 75,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 2),
                    blurRadius: 20,
                    color: Colors.black.withOpacity(0.1),
                  ),
                ],
                color: kcWhite,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 2),
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.1),
                  ),
                ],
                color: kcWhite,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  iconTabButton(
                    0,
                    'Home',
                    'assets/icons/home_icon_filled.png',
                    'assets/icons/home_icon.png',
                  ),
                  iconTabButton(
                    1,
                    'Orders',
                    'assets/icons/order_icon_filled.png',
                    'assets/icons/order_icon.png',
                  ),
                  iconTabButton(
                    2,
                    'Cart',
                    'assets/icons/cart_icon_filled.png',
                    'assets/icons/cart_icon.png',
                  ),
                  iconTabButton(
                    3,
                    'Profile',
                    'assets/icons/profile_icon_filled.png',
                    'assets/icons/profile_icon.png',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget iconTabButton(int index, String label, String imgPathSelected,
      String imgPathUnselected) {
    return MaterialButton(
      minWidth: 75,
      shape: cornerR(r: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //gaphr(h: 15),
          Image.asset(
            currentIndex == index ? imgPathSelected : imgPathUnselected,
            height: 24,
          ),
          gaphr(h: 5),
          Text(
            label,
            style: kwtextStyleRD(
                c: currentIndex == index ? kcPrimary : kcGreyLabel),
          )
        ],
      ),
      onPressed: () {
        setState(() {
          currentIndex = index;
        });
      },
    );
  }
}
