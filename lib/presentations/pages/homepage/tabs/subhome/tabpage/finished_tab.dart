import 'package:carrypill/constants/constant_color.dart';
import 'package:carrypill/constants/constant_string.dart';
import 'package:carrypill/constants/constant_widget.dart';
import 'package:carrypill/data/models/status_enum.dart';
import 'package:carrypill/presentations/custom_widgets/dash_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FinishedTab extends StatefulWidget {
  const FinishedTab({Key? key}) : super(key: key);

  @override
  _FinishedTabState createState() => _FinishedTabState();
}

class _FinishedTabState extends State<FinishedTab> {
  @override
  Widget build(BuildContext context) {
    StatusOrder statusOrder = StatusOrder.findingDriver;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: Column(
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
              child: statusWidget(statusOrder),
            ),
          ),
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
                            image: AssetImage(
                                'assets/images/request_delivery.png'),
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
                        'RM 15.00',
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
                        'RM 15.00',
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
          gaphr(h: 23),
        ],
      ),
    );
  }

  Column statusWidget(StatusOrder statusOrder) {
    late Widget statusWidget;
    late String textOrange;
    late String description;
    switch (statusOrder) {
      case StatusOrder.orderReceived:
        textOrange = 'Congratulation!';
        description = ksorderReceived;
        statusWidget = kwOrderReceivedStatusWidget;
        break;
      case StatusOrder.findingDriver:
        textOrange = 'Finding you a driver';
        description = ksorderReceived;
        statusWidget = kwfindingDriverStatusWidget;
        break;
      case StatusOrder.driverFound:
        textOrange = 'Driver Found!';
        description = ksorderReceived;
        break;
      case StatusOrder.driverToHospital:
        textOrange = 'On it!';
        description = ksdriverToHospital;
        break;
      case StatusOrder.driverQueue:
        textOrange = 'Queueing';
        description = ksdriverQueue;
        break;
      case StatusOrder.orderPreparing:
        textOrange = 'Waiting';
        description = ksorderPreparing;
        break;
      case StatusOrder.outForDelivery:
        textOrange = 'Out for Delivery!';
        description = ksoutForDelivery;
        break;
      case StatusOrder.orderArrived:
        textOrange = 'Arrived!';
        description = ksorderArrived;
        break;
      case StatusOrder.orderComplete:
        textOrange = 'Arrived!';
        description = ksorderArrived;
        break;
      default:
        textOrange = 'Order Error ';
        description = 'system error for the current order';
        break;
    }
    print(textOrange);
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
}
