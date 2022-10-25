import 'dart:async';

import 'package:carrypill/constants/constant_color.dart';
import 'package:carrypill/constants/constant_string.dart';
import 'package:carrypill/constants/constant_widget.dart';
import 'package:carrypill/data/dataproviders/firebase_provider/firestore_provider.dart';
import 'package:carrypill/data/models/order_service.dart';
import 'package:carrypill/data/models/patient.dart';
import 'package:carrypill/data/models/all_enum.dart';
import 'package:carrypill/data/models/patient_uid.dart';
import 'package:carrypill/data/models/rider.dart';
import 'package:carrypill/data/repositories/firebase_repo/auth_repo.dart';
import 'package:carrypill/data/repositories/firebase_repo/firestore_repo.dart';
import 'package:carrypill/presentations/custom_widgets/dash_line.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FinishedTab extends StatefulWidget {
  const FinishedTab({Key? key}) : super(key: key);

  @override
  _FinishedTabState createState() => _FinishedTabState();
}

class _FinishedTabState extends State<FinishedTab> {
  Rider? rider;
  Widget statusWidget = kwOrderReceivedStatusWidget;
  String textOrange = 'Congratulation!';
  String description = ksorderReceived;
  late Widget cardBottomWidget;
  StreamSubscription? streamSubscription;
  // Patient patient = Patient(
  //     name: 'name',
  //     icNum: 'icNum',
  //     phoneNum: 'phoneNum',
  //     patientId: 'patientId',
  //     address: 'address',
  //     clinicList: [],
  //     appointment: DateTime.now());

  @override
  void initState() {
    // TODO: implement initState
    // AuthRepo().register(patient, 'test@gmail.com', '123456');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //StatusOrder statusOrder = StatusOrder.noOrder;
    PatientUid useraccount = Provider.of<PatientUid>(context);
    return StreamBuilder<OrderService>(
        stream: FirestoreRepo().streamCurrentOrder(),
        builder: (_, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            OrderService orderService = snapshot.data;
            // print(orderService.statusOrder);
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: Builder(builder: (context) {
                  // late Widget statusWidget;
                  // late String textOrange;
                  // late String description;
                  // late Widget cardBottomWidget;

                  switch (orderService.statusOrder) {
                    // case StatusOrder.orderReceived:
                    //   textOrange = 'Congratulation!';
                    //   description = ksorderReceived;
                    //   statusWidget = kwOrderReceivedStatusWidget;
                    //   cardBottomWidget =
                    //       deliveryServiceStatusWidget(orderService);
                    //   break;
                    case StatusOrder.findingDriver:
                      // textOrange = 'Congratulation!';
                      // description = ksorderReceived;
                      // statusWidget = kwOrderReceivedStatusWidget;
                      cardBottomWidget =
                          deliveryServiceStatusWidget(orderService);
                      Future.delayed(const Duration(seconds: 2), () async {
                        if (orderService.orderQueryStatus == null) {
                          await FirestoreRepo().updateOrderQueryStatus(
                              'findingDriver', orderService.documentID!);
                          setState(() {});
                        }
                        if (streamSubscription == null) {
                          streamStartFindRider(orderService.documentID!);
                        }

                        textOrange = 'Finding you a driver';
                        description = ksorderReceived;
                        statusWidget = kwfindingDriverStatusWidget;
                        cardBottomWidget =
                            deliveryServiceStatusWidget(orderService);
                      });
                      break;
                    case StatusOrder.driverFound:
                      streamSubscription
                          ?.cancel()
                          .then((_) => streamSubscription = null);
                      textOrange = 'Driver Found!';
                      description = ksorderReceived;
                      statusWidget = driverfoundStatusWidget(
                          'Mohamed Salah', 'Ysuku', 'DBQ 4021', 4.5);
                      cardBottomWidget =
                          deliveryServiceStatusWidget(orderService);

                      break;
                    case StatusOrder.driverToHospital:
                      textOrange = 'On it!';
                      description = ksdriverToHospital;
                      statusWidget = kwdriverToHospitalStatusWidget;
                      cardBottomWidget = driverInfoStatusWidget(
                          driverInfoWidget(
                              'Mohamed Salah', 'Ysuku', 'DBQ 4021', 4.5),
                          orderService,
                          useraccount.uid);
                      break;
                    case StatusOrder.driverQueue:
                      textOrange = 'Queueing';
                      description = ksdriverQueue;
                      statusWidget = kwdriverQueueStatusWidget;
                      cardBottomWidget = driverInfoStatusWidget(
                          driverInfoWidget(
                              'Mohamed Salah', 'Ysuku', 'DBQ 4021', 4.5),
                          orderService,
                          useraccount.uid);
                      break;
                    case StatusOrder.orderPreparing:
                      textOrange = 'Waiting';
                      description = ksorderPreparing;
                      statusWidget = kworderPreparingStatusWidget;
                      cardBottomWidget = driverInfoStatusWidget(
                          driverInfoWidget(
                              'Mohamed Salah', 'Ysuku', 'DBQ 4021', 4.5),
                          orderService,
                          useraccount.uid);
                      break;
                    case StatusOrder.outForDelivery:
                      textOrange = 'Out for Delivery!';
                      description = ksoutForDelivery;
                      statusWidget = kwOutForDeliveryStatusWidget;
                      cardBottomWidget = driverInfoStatusWidget(
                          driverInfoWidget(
                              'Mohamed Salah', 'Ysuku', 'DBQ 4021', 4.5),
                          orderService,
                          useraccount.uid);
                      break;
                    case StatusOrder.orderArrived:
                      textOrange = 'Arrived!';
                      description = ksorderArrived;
                      statusWidget = kworderArrivedStatusWidget;
                      cardBottomWidget = driverInfoStatusWidget(
                          driverInfoWidget(
                              'Mohamed Salah', 'Ysuku', 'DBQ 4021', 4.5),
                          orderService,
                          useraccount.uid,
                          arrived: true);
                      break;
                    // case StatusOrder.orderComplete:
                    //   textOrange = 'Arrived!';
                    //   description = ksorderArrived;
                    //   statusWidget = kworderArrivedStatusWidget;
                    //   cardBottomWidget = driverInfoStatusWidget(
                    //       driverInfoWidget('Mohamed Salah', 'Ysuku', 'DBQ 4021', 4.5),
                    //       arrived: true);
                    //   break;
                    default:
                      textOrange = 'Order Error ';
                      description = 'system error for the current order';
                      statusWidget = gapw(w: 0);
                      cardBottomWidget = gapw(w: 0);
                      break;
                  }
                  // Future.delayed(
                  //   const Duration(seconds: 3),
                  //   () async {
                  //     OrderService orderService =
                  //         await FirestoreRepo(uid: useraccount.uid)
                  //             .getOrderService();
                  //     // await FirestoreProvider().getOrderService();
                  //     String? uid = orderService.documentID;

                  //     if (uid != null &&
                  //         orderService.statusOrder ==
                  //             StatusOrder.orderReceived) {
                  //       FirestoreRepo()
                  //           .updateStatusOrder(StatusOrder.findingDriver, uid);
                  //     }
                  //   },
                  // );
                  return Column(
                    children: [
                      gaphr(h: 110),
                      gaphr(h: 45.5),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: kcWhite,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: orderStatusWidget(
                              statusWidget, textOrange, description),
                        ),
                      ),
                      cardBottomWidget,
                      gaphr(h: 23),
                    ],
                  );
                }),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        });
  }

  streamStartFindRider(String orderId) {
    Stream<List<Rider>?> streamRiders =
        FirestoreRepo().streamFindRiderAvailable();
    streamSubscription = streamRiders.listen((event) async {
      if (event != null && event.isNotEmpty) {
        streamSubscription?.pause();
        for (var i = 0; i < event.length; i++) {
          Rider rider = event[i];
          if (rider.orderCancelId != null) {
            if (rider.orderCancelId!.isNotEmpty &&
                !rider.orderCancelId!.contains(orderId)) {
              await FirestoreRepo()
                  .updateRiderPending(rider.documentID!, orderId);
              break;
            } else {
              if (streamSubscription!.isPaused) {
                streamSubscription?.resume();
              }
            }
            //progress
          } else {
            await FirestoreRepo()
                .updateRiderPending(rider.documentID!, orderId);
            break;
          }
        }
      }
    });
  }

  Widget driverInfoStatusWidget(
      Widget driverInfo, OrderService orderService, String patientUid,
      {bool arrived = false}) {
    return Column(
      children: [
        gaphr(h: 16.5),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: kcWhite,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                gaphr(h: 19),
                driverInfo,
                gaphr(h: 10),
                kwDivider,
                gaphr(h: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Charge',
                      style: kwtextStyleRD(
                        c: kctextTitle,
                        fs: 15,
                        fw: FontWeight.w600,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: kccontainerPink,
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 7.w, vertical: 1.h),
                        child: Text(
                          'AHD001D',
                          style: kwtextStyleRD(fs: 15, c: kctextpurplepink),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    )
                  ],
                ),
                gaphr(h: 12),
                Text(
                  DateFormat('dd/MM/yyyy').format(
                      orderService.orderDate ?? DateTime.now()), //'22/02/2022',
                  style: kwtextStyleRD(
                    c: kcGreyLabel,
                    fs: 15,
                  ),
                ),
                gaphr(h: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Service Charge',
                      style: kwtextStyleRD(
                        c: kctextTitle,
                        fs: 15,
                        fw: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'RM ${orderService.totalPay.toStringAsFixed(2)}', //'RM 15.00',
                      style: kwtextStyleRD(
                        c: kcprimarySwatch,
                        fs: 15,
                        fw: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                gaphr(h: 15),
              ],
            ),
          ),
        ),
        gaphr(h: arrived ? 26.h : 8.5),
        arrived
            ? MaterialButton(
                color: kcPrimary,
                height: 44.h,
                minWidth: double.infinity,
                shape: cornerR(r: 8),
                child: Text(
                  'Continue',
                  style: kwtextStyleRD(
                    fs: 17,
                    c: kcWhite,
                    fw: FontWeight.w500,
                  ),
                ),
                onPressed: () async {
                  OrderService orderService =
                      await FirestoreRepo(uid: patientUid).getOrderService();
                  String? uid = orderService.documentID;

                  if (uid != null &&
                      orderService.statusOrder == StatusOrder.orderArrived) {
                    FirestoreRepo()
                        .updateOrderDateComplete(DateTime.now(), uid);
                    Navigator.of(context).pop();
                  }
                },
              )
            : Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                        shape: cornerR(r: 25),
                        height: 38.h,
                        color: kcWhite,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/icons/call_icon.png',
                              height: 13,
                            ),
                            gapwr(w: 10),
                            Text(
                              'Call',
                              style: kwtextStyleRD(
                                fs: 10,
                                c: kcPrimary,
                                fw: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        onPressed: () {}),
                  ),
                  gapwr(w: 10),
                  Expanded(
                    child: MaterialButton(
                        shape: cornerR(r: 25),
                        color: kcPrimary,
                        height: 38.h,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset('assets/icons/chat_icon.png',
                                height: 13),
                            gapwr(w: 10),
                            Text(
                              'Message',
                              style: kwtextStyleRD(
                                fs: 10,
                                c: kcWhite,
                                fw: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        onPressed: () {}),
                  )
                ],
              ),
      ],
    );
  }

  Widget deliveryServiceStatusWidget(OrderService orderService) {
    return Column(
      children: [
        gaphr(h: 30.5),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: kcWhite,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                gaphr(h: 15),
                Row(
                  children: [
                    Container(
                      height: 66.h,
                      width: 114.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: kcServiceBg,
                        image: DecorationImage(
                          image:
                              AssetImage('assets/images/request_delivery.png'),
                        ),
                      ),
                    ),
                    gapwr(w: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment:
                        //     MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Delivery',
                            style: kwtextStyleRD(
                              c: kctextTitle,
                              fs: 15,
                              fw: FontWeight.w600,
                            ),
                          ),
                          gaphr(h: 8),
                          Text(
                            'Hospital Sultan Abdul Halim',
                            style: kwtextStyleRD(
                              c: kcSubtitleService.withOpacity(0.56),
                              fs: 12,
                              fw: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                gaphr(h: 15),
                kwDivider,
                gaphr(h: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Charge',
                      style: kwtextStyleRD(
                        c: kctextTitle,
                        fs: 15,
                        fw: FontWeight.w600,
                      ),
                    ),
                    //tokenNumberWidget('AHD001D'),
                    gapw(w: 0),
                  ],
                ),
                gaphr(h: 12),
                Text(
                  '22/02/2022',
                  style: kwtextStyleRD(
                    c: kcGreyLabel,
                    fs: 15,
                  ),
                ),
                gaphr(h: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Service Charge',
                      style: kwtextStyleRD(
                        c: kctextTitle,
                        fs: 15,
                        fw: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'RM ${orderService.totalPay.toStringAsFixed(2)}', //'RM 15.00',
                      style: kwtextStyleRD(
                        c: kcprimarySwatch,
                        fs: 15,
                        fw: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                gaphr(h: 15),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: const MySeparator(
            color: kcGreyLabel,
            width: 4,
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: kcWhite,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                gaphr(h: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Pay',
                      style: kwtextStyleRD(
                        c: kctextTitle,
                        fs: 17,
                        fw: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'RM ${orderService.totalPay.toStringAsFixed(2)}', //'RM 15.00',
                      style: kwtextStyleRD(
                        c: kcOrange,
                        fs: 17,
                        fw: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                gaphr(h: 15),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Container tokenNumberWidget(String token) {
    return Container(
      decoration: BoxDecoration(
          color: kccontainerPink, borderRadius: BorderRadius.circular(10.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 1.h),
        child: Text(
          token,
          style: kwtextStyleRD(fs: 15, c: kctextpurplepink),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  Column orderStatusWidget(
      Widget statusWidget, String textOrange, String description) {
    return Column(
      children: [
        statusWidget,
        Text(
          textOrange, //'Congratulation!',
          style: kwtextStyleRD(
            ff: 'SF UI Text',
            fs: 32,
            c: kcOrange,
            fw: FontWeight.w500,
          ),
        ),
        gaphr(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Text(
            description, //ksorderReceived,
            style: kwtextStyleRD(fs: 15, c: kctextgrey, fw: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
        gaphr(h: 49.5),
      ],
    );
  }

  Widget driverfoundStatusWidget(
      String name, String vehicleName, String vehiclePlateNum, double rate) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        gaphr(h: 63.5),
        driverInfoWidget(name, vehicleName, vehiclePlateNum, rate),
        gaphr(h: 42)
      ],
    );
  }

  Widget driverInfoWidget(
      String name, String vehicleName, String vehiclePlateNum, double rate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 54.h,
          height: 54.h,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/images/mohamedsalah.png'),
            ),
          ),
        ),
        gapwr(w: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: kwtextStyleRD(
                fs: 14,
                c: kcPrimary,
                fw: FontWeight.w600,
              ),
            ),
            Text(
              '$vehicleName ($vehiclePlateNum)',
              style: kwtextStyleRD(
                fs: 14,
                c: kcsubtitleListTile1,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${rate.toStringAsFixed(1)}',
                  style: kwtextStyleRD(
                      fs: 12, c: kcsubtitle3, fw: FontWeight.bold),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
