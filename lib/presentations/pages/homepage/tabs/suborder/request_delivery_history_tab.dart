import 'package:carrypill/constants/constant_color.dart';
import 'package:carrypill/constants/constant_widget.dart';
import 'package:carrypill/data/models/order_service.dart';
import 'package:carrypill/data/models/patient_uid.dart';
import 'package:carrypill/data/repositories/firebase_repo/firestore_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RequestDeliveryHistoryTab extends StatefulWidget {
  const RequestDeliveryHistoryTab({Key? key}) : super(key: key);

  @override
  State<RequestDeliveryHistoryTab> createState() =>
      _RequestDeliveryHistoryTabState();
}

class _RequestDeliveryHistoryTabState extends State<RequestDeliveryHistoryTab> {
  @override
  Widget build(BuildContext context) {
    PatientUid useraccount = Provider.of<PatientUid>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 1),
                  blurRadius: 20,
                  color: Colors.black.withOpacity(0.17),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  gaphr(),
                  Align(
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
                  gaphr(),
                  divider(
                    t: 2,
                  ),
                  StreamBuilder(
                      stream: FirestoreRepo(uid: useraccount.uid)
                          .streamListOrderDelivery(),
                      builder: ((_, AsyncSnapshot snapshot) {
                        // print(snapshot);
                        if (snapshot.hasData) {
                          List<OrderService> orderServiceList = snapshot.data;
                          if (orderServiceList.isNotEmpty) {
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: orderServiceList.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    orderServiceList[index]
                                        .facility!
                                        .facilityName,
                                    style: kwtextStyleRD(
                                        fw: kfbold, fs: 16, c: kcBlack),
                                    // orderServiceList[index]
                                    //       .serviceType
                                    //       ?.name ??
                                    //   ''
                                  ),
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
                                      Text(
                                        'RM ${orderServiceList[index].totalPay.toStringAsFixed(2)}',
                                        style: kwtextStyleRD(
                                          fs: 14,
                                          c: kcOrange,
                                          fw: kfextrabold,
                                        ),
                                      ),
                                      Text(DateFormat('h:mm a').format(
                                          orderServiceList[index].orderDate ??
                                              DateTime.now())),
                                    ],
                                  ),
                                );
                              },
                            );
                          } else {
                            return const ListTile(
                              contentPadding: kwInset0,
                              title: Text('No order'),
                            );
                          }
                        } else {
                          return SizedBox(
                            width: double.infinity,
                            height: 200,
                            child: Center(child: loadingPillriveR(100)),
                          );
                        }
                      })),
                  //gaphr(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
