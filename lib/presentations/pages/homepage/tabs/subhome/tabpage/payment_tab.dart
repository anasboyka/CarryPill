import 'package:carrypill/constants/constant_color.dart';
import 'package:carrypill/constants/constant_widget.dart';
import 'package:carrypill/data/models/payment_type.dart';
import 'package:carrypill/presentations/custom_widgets/dash_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentTab extends StatefulWidget {
  final void Function(int index) changePage;
  const PaymentTab({Key? key, required this.changePage}) : super(key: key);

  @override
  _PaymentTabState createState() => _PaymentTabState();
}

class _PaymentTabState extends State<PaymentTab> {
  List<PaymentType> paymentTypeList = [
    PaymentType(
      imgPath: 'assets/images/debit_credit.png',
      paymentName: 'Debit/Credit Card',
    ),
    PaymentType(
      imgPath: 'assets/images/fpx.png',
      paymentName: 'Online Banking',
    ),
    PaymentType(
      imgPath: 'assets/images/cod.png',
      paymentName: 'Payment in cash',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        gaphr(h: 110),
        Expanded(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
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
                      Text(
                        'Add new method',
                        style: kwtextStyleRD(
                          c: kcOrange,
                          fs: 15,
                          fw: FontWeight.w500,
                        ),
                      ),
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
                            shape: cornerR(r: 4),
                            tileColor: kcWhite,
                            onTap: () {
                              goToPayment(index);
                            },
                          ),
                        );
                      }),
                  // Column(
                  //   children: [
                  //     ListTile(
                  //       title: Text(
                  //         paymentTypeList[0].paymentName,
                  //         style: kwtextStyleRD(
                  //             fs: 15, fw: FontWeight.w600, c: kctextDark),
                  //       ),
                  //       leading: Image.asset(paymentTypeList[0].imgPath,
                  //           height: 33.h),
                  //       shape: cornerR(r: 4),
                  //       tileColor: kcWhite,
                  //     )
                  //   ],
                  // )
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
                shape: cornerR(r: 8),
                height: 44.h,
                minWidth: double.infinity,
                color: kcPrimary,
                onPressed: () {
                  widget.changePage(1);
                },
                child: textBtn15('Place Order'),
              ),
            ),
          ),
        )
      ],
    );
  }

  void goToPayment(int index) {
    print(index);
  }
}
