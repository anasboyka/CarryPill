import 'package:carrypill/business_logic/provider/order_provider.dart';
import 'package:carrypill/constants/constant_color.dart';
import 'package:carrypill/constants/constant_widget.dart';
import 'package:carrypill/data/models/all_enum.dart';
import 'package:carrypill/data/models/order_service.dart';
import 'package:carrypill/data/models/payment_type.dart';
import 'package:carrypill/data/repositories/firebase_repo/firestore_repo.dart';
import 'package:carrypill/presentations/custom_widgets/dash_line.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PaymentTab extends StatefulWidget {
  final void Function(int index) changePage;
  final OrderService? orderService;
  const PaymentTab({Key? key, required this.changePage, this.orderService})
      : super(key: key);

  @override
  _PaymentTabState createState() => _PaymentTabState();
}

class _PaymentTabState extends State<PaymentTab> {
  List<PaymentType> paymentTypeList = [
    PaymentType(
      imgPath: 'assets/images/debit_credit.png',
      paymentName: 'Debit/Credit Card',
      paymentMethod: PaymentMethod.debitcredit,
    ),
    PaymentType(
      imgPath: 'assets/images/fpx.png',
      paymentName: 'Online Banking',
      paymentMethod: PaymentMethod.fpx,
    ),
    PaymentType(
      imgPath: 'assets/images/cod.png',
      paymentName: 'Payment in cash',
      paymentMethod: PaymentMethod.cash,
    ),
  ];

  int? currentIndex;
  @override
  void initState() {
    // TODO: implement initState
    //print('init');
    //print(widget.orderService?.facility);
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   Provider.of<OrderProvider>(context, listen: false)
    //       .updatePatient(widget.patient);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var orderProvider = Provider.of<OrderProvider>(context);
    //print(orderProvider.orderService.facility);
    return Column(
      children: [
        gaphr(h: 110),
        Expanded(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Column(
                children: [
                  gaphr(h: 12.5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Service',
                      style: kwtextStyleRD(
                        c: kcPrimary,
                        fs: 17,
                        fw: FontWeight.w600,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  gaphr(h: 8),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: kcWhite,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
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
                                    image: AssetImage(orderProvider
                                                .orderService.serviceType ==
                                            ServiceType.requestDelivery
                                        ? 'assets/images/request_delivery.png'
                                        : 'assets/images/request_pickup.png'),
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
                                      orderProvider.orderService.serviceType ==
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
                                      orderProvider.orderService.facility
                                              ?.facilityName ??
                                          "",
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
                          Text(
                            'Charge',
                            style: kwtextStyleRD(
                              c: kctextTitle,
                              fs: 15,
                              fw: FontWeight.w600,
                            ),
                          ),
                          gaphr(h: 12),
                          Text(
                            DateFormat("dd/MM/yyyy").format(DateTime.now()),
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
                                'RM ${orderProvider.orderService.totalPay.toStringAsFixed(2)}',
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
                                'RM ${orderProvider.orderService.totalPay.toStringAsFixed(2)}',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payment Methods',
                        style: kwtextStyleRD(
                          c: kcprimarySwatch,
                          fs: 17,
                          fw: FontWeight.w600,
                        ),
                      ),
                      // Text(
                      //   'Add new method',
                      //   style: kwtextStyleRD(
                      //     c: kcOrange,
                      //     fs: 15,
                      //     fw: FontWeight.w500,
                      //   ),
                      // ),
                    ],
                  ),
                  gaphr(h: 15),
                  ListView.builder(
                      itemCount: paymentTypeList.length,
                      shrinkWrap: true,
                      padding: kwInset0,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: ListTile(
                            title: Text(
                              paymentTypeList[index].paymentName,
                              style: kwtextStyleRD(
                                  fs: 15, fw: FontWeight.w600, c: kctextDark),
                            ),
                            leading: Image.asset(paymentTypeList[index].imgPath,
                                height: 33.h),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r),
                                side: (currentIndex != null &&
                                        currentIndex == index)
                                    ? const BorderSide(
                                        color: kcPrimary,
                                        width: 1,
                                      )
                                    : BorderSide.none),
                            tileColor: kcWhite,
                            onTap: () async {
                              Provider.of<OrderProvider>(context, listen: false)
                                  .setPaymentMethod(
                                      paymentTypeList[index].paymentMethod);

                              onPaymentSelected(index);
                            },
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 95.h,
          width: double.infinity,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 37.5.w),
              child: MaterialButton(
                onPressed: () async {
                  if (currentIndex != null) {
                    Provider.of<OrderProvider>(context, listen: false)
                        .setOrderDate(DateTime.now());
                    Provider.of<OrderProvider>(context, listen: false)
                        .setOrderStatus(StatusOrder.findingDriver);

                    // print(Provider.of<OrderProvider>(context, listen: false)
                    //     .orderService);
                    OrderService orderService =
                        Provider.of<OrderProvider>(context, listen: false)
                            .orderService;
                    DocumentReference docRef =
                        await FirestoreRepo().addOrder(orderService);

                    widget.changePage(2);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please select your payment method')),
                    );
                  }
                },
                shape: cornerR(r: 8),
                height: 44.h,
                minWidth: double.infinity,
                color: kcPrimary,
                child: textBtn15('Place Order'),
              ),
            ),
          ),
        )
      ],
    );
  }

  void onPaymentSelected(int index) {
    setState(() {
      currentIndex = index;
    });
    // print(index);
  }
}
