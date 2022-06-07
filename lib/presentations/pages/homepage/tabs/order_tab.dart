import 'package:carrypill/constants/constant_color.dart';
import 'package:carrypill/data/models/order_service.dart';
import 'package:carrypill/data/models/patient_uid.dart';
import 'package:carrypill/data/repositories/firebase_repo/firestore_repo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
    PatientUid useraccount = Provider.of<PatientUid>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('OrderTab'),
        ),
        body: Column(
          children: [
            gaphr(h: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Order History',
                  style: kwtextStyleRD(
                    c: kcPrimary,
                    fs: 17,
                    fw: FontWeight.w600,
                  ),
                ),
              ),
            ),
            gaphr(),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.white),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    gaphr(),
                    StreamBuilder(
                        stream: FirestoreRepo(uid: useraccount.uid)
                            .streamListOrder(),
                        builder: ((_, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            List<OrderService> orderServiceList = snapshot.data;
                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: orderServiceList.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(orderServiceList[index]
                                          .serviceType
                                          ?.name ??
                                      ''),
                                  // 'RM ${orderServiceList[index].totalPay.toStringAsFixed(2)}'),
                                  subtitle: Text(DateFormat('dd/MM/yyyy')
                                      .format(
                                          orderServiceList[index].orderDate ??
                                              DateTime.now())),
                                  trailing: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(DateFormat('h:mm a').format(
                                          orderServiceList[index].orderDate ??
                                              DateTime.now())),
                                      Text(
                                          'RM ${orderServiceList[index].totalPay.toStringAsFixed(2)}'),
                                    ],
                                  ),
                                );
                              },
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator.adaptive());
                          }
                        })),
                    gaphr(),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
