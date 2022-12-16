import 'package:carrypill/business_logic/provider/order_provider.dart';
import 'package:carrypill/data/models/all_enum.dart';
import 'package:carrypill/data/models/patient.dart';
import 'package:carrypill/data/models/patient_uid.dart';
import 'package:carrypill/data/repositories/firebase_repo/auth_repo.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constant_color.dart';
import '../../../../constants/constant_string.dart';
import '../../../../constants/constant_widget.dart';
import '../../../custom_widgets/paint/home_paint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTab extends StatefulWidget {
  Patient patient;
  HomeTab({Key? key, required this.patient}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late Patient patient;
  @override
  void initState() {
    // TODO: implement initState
    patient = widget.patient;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final patientuid = Provider.of<PatientUid?>(context);
    return Stack(
      children: [
        SizedBox(
          height: 204.h,
          width: double.infinity,
          child: CustomPaint(
            painter: HomeTabHeaderPainter(),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  //height: 206.h,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        gaphr(h: 47),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Hi ',
                                    style: kwtextStyleRD(
                                      fs: 34.sp,
                                      c: Colors.white,
                                      fw: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: patient.name
                                        .split(' ')
                                        .first, //'Samad',
                                    style: kwtextStyleRD(
                                        fs: 34.sp,
                                        c: kcLightYellow,
                                        fw: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.notifications_outlined,
                                color: Colors.white,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                        gaphr(h: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 18,
                            ),
                            gapwr(w: 5),
                            Flexible(
                              child: Text(
                                patient.address ??
                                    "Set your address", //'225, Bandar Amanjaya, 08000 Sungai Petani Kedah',
                                style: kwtextStyleRD(
                                  fs: 12,
                                  fw: FontWeight.w600,
                                  c: kcWhite,
                                ),
                              ),
                            )
                          ],
                        ),
                        gaphr(h: 10),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: SizedBox(
                        //         height: 44.h,
                        //         width: double.infinity,
                        //         child: TextField(
                        //           // controller: controller,

                        //           style: kwstyleb15,
                        //           decoration: InputDecoration(
                        //             border: OutlineInputBorder(
                        //               borderRadius: BorderRadius.circular(8.r),
                        //               // borderSide:
                        //               //     const BorderSide(color: kOutlineTextField),
                        //             ),
                        //             enabledBorder: OutlineInputBorder(
                        //               borderRadius: BorderRadius.circular(8.r),
                        //               // borderSide:
                        //               //     const BorderSide(color: kOutlineTextField),
                        //             ),
                        //             focusedBorder: OutlineInputBorder(
                        //               borderRadius: BorderRadius.circular(8.r),
                        //               // borderSide: const BorderSide(
                        //               //     color: kLightYellow, width: 2),
                        //             ),
                        //             disabledBorder: OutlineInputBorder(
                        //               borderRadius: BorderRadius.circular(8.r),
                        //               // borderSide:
                        //               //     const BorderSide(color: kOutlineTextField),
                        //             ),
                        //             errorBorder: OutlineInputBorder(
                        //               borderRadius: BorderRadius.circular(8.r),
                        //               borderSide:
                        //                   const BorderSide(color: Colors.red),
                        //             ),
                        //             isDense: true,
                        //             contentPadding: const EdgeInsets.fromLTRB(
                        //                 20, 12, 12, 12),
                        //             fillColor: Colors.white,
                        //             filled: true,
                        //             hintText: 'Hospital Sultan Abdul Halim',
                        //             hintStyle: kwstyleHint15,
                        //             prefixIcon: const Icon(
                        //               Icons.search_rounded,
                        //               size: 17,
                        //               color: kcHintTextSearch,
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     gapwr(w: 8),
                        //     MaterialButton(
                        //       shape: cornerR(r: 8),
                        //       color: kcWhite,
                        //       minWidth: 42,
                        //       height: 42,
                        //       padding: EdgeInsets.zero,
                        //       child: const Icon(
                        //         Icons.filter_list,
                        //         color: kcHintTextSearch,
                        //         size: 24,
                        //       ),
                        //       onPressed: () {},
                        //     )
                        //   ],
                        // )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: MaterialButton(
                          elevation: 1,
                          color: kcWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          onPressed: () {
                            Provider.of<OrderProvider>(context, listen: false)
                                .setServiceType(ServiceType.requestPickup);
                            Provider.of<OrderProvider>(context, listen: false)
                                .setPatientRef(patientuid!.uid);
                            Navigator.of(context).pushNamed('/requestservice');
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              gaphr(h: 25),
                              Image.asset(
                                'assets/images/request_pickup.png',
                                height: 122.h,
                              ),
                              gaphr(h: 3),
                              Text(
                                'Request\nPickup',
                                style: kwtextStyleRD(
                                  fs: 30,
                                  c: kcPrimary,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                ksrequesPickupDetail,
                                style: kwtextStyleRD(
                                    fs: 13, c: kcRequestPickupDescrp, h: 1.15),
                                textAlign: TextAlign.left,
                              ),
                              gaphr(h: 7)
                            ],
                          ),
                        ),
                        // child: InkWell(
                        //   borderRadius: BorderRadius.circular(25.r),
                        //   radius: 300,
                        //   splashColor: Colors.grey.shade300.withOpacity(0.8),
                        //   highlightColor: Colors.grey.shade800.withOpacity(0.2),
                        //   child: Ink(
                        //     padding: EdgeInsets.symmetric(horizontal: 20.w),
                        //     width: double.infinity,
                        //     decoration: BoxDecoration(
                        //         color: Colors.white,
                        //         borderRadius: BorderRadius.circular(25.r),
                        //         boxShadow: [
                        //           BoxShadow(
                        //             blurRadius: 10,
                        //             offset: const Offset(2, 5),
                        //             color: Colors.black.withOpacity(0.05),
                        //           )
                        //         ]),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         gaphr(h: 25),
                        //         Image.asset(
                        //           'assets/images/request_pickup.png',
                        //           height: 122.h,
                        //         ),
                        //         gaphr(h: 3),
                        //         Text(
                        //           'Request\nPickup',
                        //           style: kwtextStyleRD(
                        //             fs: 30,
                        //             c: kcPrimary,
                        //           ),
                        //           textAlign: TextAlign.left,
                        //         ),
                        //         Text(
                        //           ksrequesPickupDetail,
                        //           style: kwtextStyleRD(
                        //               fs: 13,
                        //               c: kcRequestPickupDescrp,
                        //               h: 1.15),
                        //           textAlign: TextAlign.left,
                        //         ),
                        //         gaphr(h: 7)
                        //       ],
                        //     ),
                        //   ),
                        //   onTap: () {
                        //     //TODO
                        //   },
                        // ),
                      ),
                      gapwr(w: 10),
                      Expanded(
                        child: MaterialButton(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          color: kcWhite,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              gaphr(h: 25),
                              Image.asset(
                                'assets/images/request_delivery.png',
                                height: 122.h,
                              ),
                              gaphr(h: 3),
                              Text(
                                'Request\nDelivery',
                                style: kwtextStyleRD(
                                  fs: 30,
                                  c: kcPrimary,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                ksrequesDelivery,
                                style: kwtextStyleRD(
                                    fs: 13, c: kcRequestPickupDescrp, h: 1.15),
                                textAlign: TextAlign.left,
                              ),
                              gaphr(h: 7)
                            ],
                          ),
                          onPressed: () {
                            Provider.of<OrderProvider>(context, listen: false)
                                .setServiceType(ServiceType.requestDelivery);
                            Provider.of<OrderProvider>(context, listen: false)
                                .setPatientRef(patientuid!.uid);
                            Navigator.of(context).pushNamed('/requestservice');
                          },
                        ),
                        // child: InkWell(
                        //   borderRadius: BorderRadius.circular(25.r),
                        //   radius: 300,
                        //   splashColor: Colors.grey.shade300.withOpacity(0.8),
                        //   highlightColor: Colors.grey.shade800.withOpacity(0.2),
                        //   child: Ink(
                        //     padding: EdgeInsets.symmetric(horizontal: 20.w),
                        //     width: double.infinity,
                        //     decoration: BoxDecoration(
                        //         color: Colors.white,
                        //         borderRadius: BorderRadius.circular(25.r),
                        //         boxShadow: [
                        //           BoxShadow(
                        //             blurRadius: 10,
                        //             offset: const Offset(2, 5),
                        //             color: Colors.black.withOpacity(0.05),
                        //           )
                        //         ]),
                        //     child: SizedBox(
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           gaphr(h: 25),
                        //           Image.asset(
                        //             'assets/images/request_delivery.png',
                        //             height: 122.h,
                        //           ),
                        //           gaphr(h: 3),
                        //           Text(
                        //             'Request\nDelivery',
                        //             style: kwtextStyleRD(
                        //               fs: 30,
                        //               c: kcPrimary,
                        //             ),
                        //             textAlign: TextAlign.left,
                        //           ),
                        //           Text(
                        //             ksrequesDelivery,
                        //             style: kwtextStyleRD(
                        //                 fs: 13,
                        //                 c: kcRequestPickupDescrp,
                        //                 h: 1.15),
                        //             textAlign: TextAlign.left,
                        //           ),
                        //           gaphr(h: 7)
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        //   onTap: () async {
                        //     //TODO check if address not null
                        //     // bool profileComplete = (patient.address != null &&
                        //     //     patient.appointment != null &&
                        //     //     patient.geoPoint != null &&
                        //     //     patient.patientId != null);

                        //     //if (profileComplete) {
                        // Provider.of<OrderProvider>(context, listen: false)
                        //     .setServiceType(ServiceType.requestDelivery);
                        // Provider.of<OrderProvider>(context, listen: false)
                        //     .setPatientRef(patientuid!.uid);
                        // Navigator.of(context).pushNamed('/requestservice');
                        //     // } else {
                        //     //   ScaffoldMessenger.of(context).showSnackBar(
                        //     //     const SnackBar(
                        //     //         content: Text(
                        //     //             'Please complete your profile info before order')),
                        //     //   );
                        //     // }
                        //   },
                        // ),
                      )
                    ],
                  ),
                ),
                gaphr(h: 14),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Special Offers',
                        style: kwtextStyleRD(
                          c: kcPrimary,
                          fs: 20,
                          fw: FontWeight.w700,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'View all',
                            style: kwtextStyleRD(
                              fs: 15,
                              c: kcOrange,
                            ),
                          ),
                          const Icon(
                            Icons.double_arrow,
                            color: kcOrange,
                            size: 12,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                gaphr(h: 9),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/card1.png',
                          //height: 204.24.h,
                        ),
                        gapwr(w: 10),
                        Image.asset(
                          'assets/images/card2.png',
                          //height: 204.24.h,
                        )
                      ],
                    ),
                  ),
                ),
                // gaph(h: 600)
              ],
            ),
          ),
        )
      ],
    );
  }
}
