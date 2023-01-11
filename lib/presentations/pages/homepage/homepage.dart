import 'dart:io';

import 'package:carrypill/business_logic/provider/patient_provider.dart';
import 'package:carrypill/data/models/clinic.dart';
import 'package:carrypill/data/models/patient.dart';
import 'package:carrypill/data/repositories/firebase_repo/auth_repo.dart';
import 'package:provider/provider.dart';

import '../../../constants/constant_color.dart';
import '../../../constants/constant_widget.dart';
import 'tabs/cart_tab.dart';
import 'tabs/home_tab.dart';
import 'tabs/order_tab.dart';
import 'tabs/profile_tab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  Patient patient;
  HomePage({Key? key, required this.patient}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  // final pages = [
  //   const HomeTab(),
  //   const OrderTab(),
  //   const CartTab(),
  //   ProfileTab(patient: Provider.of<PatientProvider>(context).patient!),
  // ];

  // Patient patient = Patient(
  //     name: 'name',
  //     icNum: 'icNum',
  //     phoneNum: 'phoneNum',
  //     patientId: 'patientId',
  //     address: 'address',
  //     clinicList: [
  //       Clinic(clinicName: 'clinicName', status: true),
  //       Clinic(clinicName: 'clinicName', status: true),
  //       Clinic(clinicName: 'clinicName', status: true),
  //     ],
  //     appointment: DateTime.now());

  @override
  void initState() {
    // TODO: implement initState
    // AuthRepo().logout();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PatientProvider>(context, listen: false)
          .updatePatient(widget.patient);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcBgHome1,
      body: IndexedStack(
        children: [
          HomeTab(patient: widget.patient),
          const OrderTab(),
          ProfileTab(patient: widget.patient),
        ],
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
