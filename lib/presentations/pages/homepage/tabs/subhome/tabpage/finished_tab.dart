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
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class FinishedTab extends StatefulWidget {
  const FinishedTab({Key? key}) : super(key: key);

  @override
  _FinishedTabState createState() => _FinishedTabState();
}

class _FinishedTabState extends State<FinishedTab> {
  Rider? currentRider;
  Widget statusWidget = kwOrderReceivedStatusWidget;
  String textOrange = 'Congratulation!';
  String description = ksorderReceived;
  late Widget cardBottomWidget;
  StreamSubscription? streamSubscription1, streamSubscription2;
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
  void dispose() {
    // TODO: implement dispose
    streamSubscription1?.cancel().then((_) => streamSubscription1 = null);
    streamSubscription2?.cancel().then((_) => streamSubscription2 = null);

    super.dispose();
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
                  if (orderService.riderRef == null) {
                    if (orderService.statusOrder == StatusOrder.findingDriver) {
                      cardBottomWidget =
                          deliveryServiceStatusWidget(orderService);
                      Future.delayed(const Duration(seconds: 2), () async {
                        if (orderService.orderQueryStatus == null) {
                          await FirestoreRepo().updateOrderQueryStatus(
                              'findingDriver', orderService.documentID!);
                          if (streamSubscription1 == null) {
                            streamStartFindRiders(orderService.documentID!);
                          }
                          setState(() {});
                        }
                        textOrange = 'Finding you a driver';
                        description = ksorderReceived;
                        statusWidget = kwfindingDriverStatusWidget;
                        cardBottomWidget =
                            deliveryServiceStatusWidget(orderService);
                      });
                    }
                    return Column(
                      children: [
                        gaphr(h: 120),
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
                    // switch (orderService.statusOrder) {
                    //   case StatusOrder.findingDriver:
                    //     cardBottomWidget =
                    //         deliveryServiceStatusWidget(orderService);
                    //     Future.delayed(const Duration(seconds: 2), () async {
                    //       if (orderService.orderQueryStatus == null) {
                    //         await FirestoreRepo().updateOrderQueryStatus(
                    //             'findingDriver', orderService.documentID!);
                    //         if (streamSubscription1 == null) {
                    //           streamStartFindRiders(orderService.documentID!);
                    //         }
                    //         setState(() {});
                    //       }
                    //       textOrange = 'Finding you a driver';
                    //       description = ksorderReceived;
                    //       statusWidget = kwfindingDriverStatusWidget;
                    //       cardBottomWidget =
                    //           deliveryServiceStatusWidget(orderService);
                    //     });
                    //     break;
                    //   case StatusOrder.driverFound:
                    //     streamSubscription1
                    //         ?.cancel()
                    //         .then((_) => streamSubscription1 = null);
                    //     streamSubscription2
                    //         ?.cancel()
                    //         .then((_) => streamSubscription2 = null);
                    //     textOrange = 'Driver Found!';
                    //     description = ksorderReceived;
                    //     statusWidget = driverfoundStatusWidget(
                    //       'Mohamed Salah',
                    //       'Ysuku',
                    //       'DBQ 4021',
                    //       4.5,
                    //       orderService.riderRef!,
                    //     );
                    //     cardBottomWidget =
                    //         deliveryServiceStatusWidget(orderService);
                    //     break;
                    //   case StatusOrder.driverToHospital:
                    //     textOrange = 'On it!';
                    //     description = ksdriverToHospital;
                    //     statusWidget = kwdriverToHospitalStatusWidget;
                    //     break;
                    //   case StatusOrder.driverQueue:
                    //     textOrange = 'Queueing';
                    //     description = ksdriverQueue;
                    //     statusWidget = kwdriverQueueStatusWidget;
                    //     cardBottomWidget = driverInfoStatusWidget(
                    //         driverInfoWidget(
                    //             'Mohamed Salah', 'Ysuku', 'DBQ 4021', 4.5),
                    //         orderService,
                    //         useraccount.uid);
                    //     break;
                    //   case StatusOrder.orderPreparing:
                    //     textOrange = 'Waiting';
                    //     description = ksorderPreparing;
                    //     statusWidget = kworderPreparingStatusWidget;
                    //     cardBottomWidget = driverInfoStatusWidget(
                    //         driverInfoWidget(
                    //             'Mohamed Salah', 'Ysuku', 'DBQ 4021', 4.5),
                    //         orderService,
                    //         useraccount.uid);
                    //     break;
                    //   case StatusOrder.outForDelivery:
                    //     textOrange = 'Out for Delivery!';
                    //     description = ksoutForDelivery;
                    //     statusWidget = kwOutForDeliveryStatusWidget;
                    //     cardBottomWidget = driverInfoStatusWidget(
                    //         driverInfoWidget(
                    //             'Mohamed Salah', 'Ysuku', 'DBQ 4021', 4.5),
                    //         orderService,
                    //         useraccount.uid);
                    //     break;
                    //   case StatusOrder.orderArrived:
                    //     textOrange = 'Arrived!';
                    //     description = ksorderArrived;
                    //     statusWidget = kworderArrivedStatusWidget;
                    //     cardBottomWidget = driverInfoStatusWidget(
                    //         driverInfoWidget(
                    //             'Mohamed Salah', 'Ysuku', 'DBQ 4021', 4.5),
                    //         orderService,
                    //         useraccount.uid,
                    //         arrived: true);
                    //     break;
                    //   default:
                    //     textOrange = 'Order Error ';
                    //     description = 'system error for the current order';
                    //     statusWidget = gapw(w: 0);
                    //     cardBottomWidget = gapw(w: 0);
                    //     break;
                    // }
                  } else {
                    return StreamBuilder(
                      stream: FirestoreRepo()
                          .getRiderStream(orderService.riderRef!),
                      builder: (_, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          Rider rider = snapshot.data;
                          switch (orderService.statusOrder) {
                            case StatusOrder.driverFound:
                              streamSubscription1
                                  ?.cancel()
                                  .then((_) => streamSubscription1 = null);
                              streamSubscription2
                                  ?.cancel()
                                  .then((_) => streamSubscription2 = null);
                              textOrange = 'Driver Found!';
                              description = ksorderReceived;
                              statusWidget = driverfoundStatusWidget(
                                ("${rider.firstName} ${rider.lastName}"), //'Mohamed Salah',
                                rider.vehicleType, //'Ysuku',
                                rider.phoneNum, //'DBQ 4021',
                                4.5,
                                orderService.riderRef!,
                              );
                              cardBottomWidget =
                                  deliveryServiceStatusWidget(orderService);
                              break;
                            // case StatusOrder.driverToHospital:
                            //   textOrange = 'On it!';
                            //   description = ksdriverToHospital;
                            //   statusWidget = kwdriverToHospitalStatusWidget;
                            //   cardBottomWidget = driverInfoStatusWidget(
                            //     driverInfoWidget(
                            //       rider,
                            //       // ("${rider.firstName} ${rider.lastName}"), //'Mohamed Salah',
                            //       // rider.vehicleType, //'Ysuku',
                            //       // rider.phoneNum, //'DBQ 4021',
                            //       // 4.5,
                            //     ),
                            //     orderService,
                            //     useraccount.uid,
                            //     rider,
                            //   );
                            //   break;
                            case StatusOrder.driverQueue:
                              textOrange = 'Queueing';
                              description = ksdriverQueue;
                              statusWidget = kwdriverQueueStatusWidget;
                              cardBottomWidget = driverInfoStatusWidget(
                                driverInfoWidget(
                                  rider,
                                  // ("${rider.firstName} ${rider.lastName}"), //'Mohamed Salah',
                                  // rider.vehicleType, //'Ysuku',
                                  // rider.phoneNum, //'DBQ 4021',
                                  // 4.5,
                                ),
                                orderService,
                                useraccount.uid,
                                rider,
                              );
                              break;
                            case StatusOrder.orderPreparing:
                              textOrange = 'Order Preparing';
                              description = ksorderPreparing;
                              statusWidget = kworderPreparingStatusWidget;
                              cardBottomWidget = driverInfoStatusWidget(
                                driverInfoWidget(
                                  rider,
                                  // ("${rider.firstName} ${rider.lastName}"), //'Mohamed Salah',
                                  // rider.vehicleType, //'Ysuku',
                                  // rider.phoneNum, //'DBQ 4021',
                                  // 4.5,
                                ),
                                orderService,
                                useraccount.uid,
                                rider,
                              );
                              break;
                            case StatusOrder.outForDelivery:
                              textOrange = 'Out for Delivery!';
                              description = ksoutForDelivery;
                              statusWidget = kwOutForDeliveryStatusWidget;
                              cardBottomWidget = driverInfoStatusWidget(
                                driverInfoWidget(
                                  rider,
                                  // ("${rider.firstName} ${rider.lastName}"), //'Mohamed Salah',
                                  // rider.vehicleType, //'Ysuku',
                                  // rider.phoneNum, //'DBQ 4021',
                                  // 4.5,
                                ),
                                orderService,
                                useraccount.uid,
                                rider,
                              );
                              break;
                            case StatusOrder.orderArrived:
                              textOrange = orderService.serviceType ==
                                      ServiceType.requestDelivery
                                  ? 'Arrived!'
                                  : 'Finished!';
                              description = orderService.serviceType ==
                                      ServiceType.requestDelivery
                                  ? ksorderArrived
                                  :
                                  // ksorderFinished1 +
                                  //     orderService.tokenNum.toString() +
                                  ksorderFinished2;
                              statusWidget = orderService.serviceType ==
                                      ServiceType.requestDelivery
                                  ? kworderArrivedStatusWidget
                                  : kworderFinishedStatusWidget(
                                      orderService.tokenUrlImage!);
                              cardBottomWidget = driverInfoStatusWidget(
                                  driverInfoWidget(
                                    rider,
                                    // ("${rider.firstName} ${rider.lastName}"), //'Mohamed Salah',
                                    // rider.vehicleType, //'Ysuku',
                                    // rider.phoneNum, //'DBQ 4021',
                                    // 4.5,
                                  ),
                                  orderService,
                                  useraccount.uid,
                                  rider,
                                  arrived: true);
                              break;
                            default:
                              textOrange = 'Order Error ';
                              description =
                                  'system error for the current order';
                              statusWidget = gapw(w: 0);
                              cardBottomWidget = gapw(w: 0);
                              break;
                          }
                          return Column(
                            children: [
                              gaphr(h: 120),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  color: kcWhite,
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  child: orderStatusWidget(
                                      statusWidget, textOrange, description),
                                ),
                              ),
                              cardBottomWidget,
                              gaphr(h: 23),
                            ],
                          );
                        } else {
                          return Center(
                            child: SizedBox(
                              width: double.infinity,
                              height: 200,
                              child: Center(
                                child: loadingPillriveR(100),
                              ),
                            ),
                          );
                        }
                      },
                    );
                  }
                  // if (currentRider == null) {
                  // return Column(
                  //   children: [
                  //     gaphr(h: 155.5),
                  //     Container(
                  //       width: double.infinity,
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(20.r),
                  //         color: kcWhite,
                  //       ),
                  //       child: Padding(
                  //         padding: EdgeInsets.symmetric(horizontal: 15.w),
                  //         child: orderStatusWidget(
                  //             statusWidget, textOrange, description),
                  //       ),
                  //     ),
                  //     cardBottomWidget,
                  //     gaphr(h: 23),
                  //   ],
                  // );
                  // } else {
                  //   cardBottomWidget = driverInfoStatusWidget(
                  //       driverInfoWidget(
                  //         currentRider!.firstName, //'Mohamed Salah',
                  //         currentRider!.vehicleType, //'Ysuku',
                  //         currentRider!.phoneNum, //'DBQ 4021',
                  //         4.5,
                  //       ),
                  //       orderService,
                  //       useraccount.uid);
                  //   return Column(
                  //     children: [
                  //       gaphr(h: 110),
                  //       gaphr(h: 45.5),
                  //       Container(
                  //         width: double.infinity,
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(20.r),
                  //           color: kcWhite,
                  //         ),
                  //         child: Padding(
                  //           padding: EdgeInsets.symmetric(horizontal: 15.w),
                  //           child: orderStatusWidget(
                  //               statusWidget, textOrange, description),
                  //         ),
                  //       ),
                  //       cardBottomWidget,
                  //       gaphr(h: 23),
                  //     ],
                  //   );
                  // }
                }),
              ),
            );
          } else {
            return Center(
              child: SizedBox(
                width: double.infinity,
                height: 200,
                child: Center(
                  child: loadingPillriveR(100),
                ),
              ),
            );
          }
        });
  }

  Future<bool?> streamCheckRiderPending(String riderId) async {
    Stream<Rider> streamRider =
        FirestoreRepo().streamRiderPendingStatus(riderId);

    await for (Rider rider in streamRider) {
      if (rider.workingStatus == 'isWaitingForOrder') {
        return false;
      } else if (rider.workingStatus == 'acceptedOrder') {
        setState(() {
          currentRider = rider;
        });

        return true;
      }
    }

    return null;

    // return streamRider.firstWhere((rider) => rider.workingStatus == '');
  }

  streamStartFindRiders(String orderId) async {
    Stream<List<Rider>?> streamRiders =
        FirestoreRepo().streamFindRidersAvailable();
    streamSubscription1 = streamRiders.listen((riderList) async {
      if (riderList != null && riderList.isNotEmpty) {
        for (var i = 0; i < riderList.length; i++) {
          // print(i);
          // print('start loop');
          Rider rider = riderList[i];

          if (rider.orderCancelId != null) {
            if (rider.orderCancelId!.isNotEmpty &&
                !rider.orderCancelId!.contains(orderId)) {
              streamSubscription1?.pause();
              // print(rider.documentID);
              await FirestoreRepo()
                  .updateRiderPending(rider.documentID!, orderId);
              bool result =
                  await streamCheckRiderPending(rider.documentID!) ?? false;
              if (result) {
                // print('if cancel id != null & after rider pending break');
                break;
              } else {
                // print('if cancel id x= null & after rider pending continue');
                continue;
              }
            } else {
              // print('stream paused');
              if (streamSubscription1!.isPaused) {
                streamSubscription1?.resume();
              }
              continue;
            }
          } else {
            streamSubscription1?.pause();
            // print(rider.documentID);
            await FirestoreRepo()
                .updateRiderPending(rider.documentID!, orderId);
            bool? result =
                await streamCheckRiderPending(rider.documentID!) ?? false;
            if (result) {
              // print('if cancel id == null & after rider pending break');
              break;
            } else {
              // print('if cancel id == null & after rider pending continue');
              continue;
            }
          }
        }
        // print('end for loop');
      } else {
        // print('rider list null or empty');
      }
    });
  }

  Widget driverInfoStatusWidget(Widget driverInfo, OrderService orderService,
      String patientUid, Rider rider,
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
                    // Container(
                    //   decoration: BoxDecoration(
                    //       color: kccontainerPink,
                    //       borderRadius: BorderRadius.circular(10.r)),
                    //   child: Padding(
                    //     padding: EdgeInsets.symmetric(
                    //         horizontal: 7.w, vertical: 1.h),
                    //     child: Text(
                    //       'AHD001D',
                    //       style: kwtextStyleRD(fs: 15, c: kctextpurplepink),
                    //       textAlign: TextAlign.left,
                    //     ),
                    //   ),
                    // )
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
            : gapw(w: 0),
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
                            orderService.serviceType ==
                                    ServiceType.requestDelivery
                                ? 'Delivery'
                                : 'Pickup',
                            style: kwtextStyleRD(
                              c: kctextTitle,
                              fs: 15,
                              fw: FontWeight.w600,
                            ),
                          ),
                          gaphr(h: 8),
                          Text(
                            orderService.facility!.facilityName,
                            //'Hospital Sultan Abdul Halim',
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
                  dateformatNumSlashI(DateTime.now()),
                  //'22/02/2022',
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

  Widget driverfoundStatusWidget(String name, String vehicleName,
      String vehiclePlateNum, double rate, String riderId) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        gaphr(h: 63.5),
        FutureBuilder(
            future: FirestoreRepo().getRider(riderId),
            builder: (_, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                Rider rider = snapshot.data;
                return driverInfoWidget(
                  //TODO LATER
                  rider,
                  // rider.firstName, //name,
                  // rider.vehicleType, //vehicleName,
                  // rider.phoneNum, //vehiclePlateNum,
                  //4.4 //rate,
                );
              } else {
                return Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: Center(
                      child: loadingPillriveR(100),
                    ),
                  ),
                );
                ;
              }
            }),
        gaphr(h: 42)
      ],
    );
  }

  Widget driverInfoWidget(
    Rider rider,
    // String name,
    // String vehicleName,
    // String vehiclePlateNum,
    //double rate,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 54.h,
          height: 54.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: NetworkImage(rider.profile!
                    .profileImageUrl!) //AssetImage('assets/images/mohamedsalah.png'),
                ),
          ),
        ),
        gapwr(w: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${rider.firstName} ${rider.lastName}', //name,
              style: kwtextStyleRD(
                fs: 14,
                c: kcPrimary,
                fw: FontWeight.w600,
              ),
            ),
            Text(
              '${rider.vehicle!.vehicleBrand!} (${rider.vehicle!.vehiclePlateNum!})',
              style: kwtextStyleRD(
                fs: 14,
                c: kcsubtitleListTile1,
              ),
            ),
            // Row(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     Text(
            //       '${rate.toStringAsFixed(1)}',
            //       style: kwtextStyleRD(
            //           fs: 12, c: kcsubtitle3, fw: FontWeight.bold),
            //     ),
            //   ],
            // )
          ],
        )
      ],
    );
  }
}
