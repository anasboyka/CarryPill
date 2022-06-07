import 'package:carrypill/business_logic/provider/order_provider.dart';
import 'package:carrypill/business_logic/provider/patient_provider.dart';
import 'package:carrypill/data/models/order_service.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/constant_color.dart';
import '../../../../../constants/constant_widget.dart';
import 'tabpage/book_appointment_tab.dart';
import 'tabpage/finished_tab.dart';
import 'tabpage/payment_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestDelivery extends StatefulWidget {
  const RequestDelivery({Key? key}) : super(key: key);

  @override
  _RequestDeliveryState createState() => _RequestDeliveryState();
}

class _RequestDeliveryState extends State<RequestDelivery>
    with SingleTickerProviderStateMixin {
  List<String> pagesTitle = ['Book Appointment', 'Payment', 'Finished'];
  // List<Widget> pages = [
  //   BookAppointmentTab(),
  //   PaymentTab(),
  //   FinishedTab(),
  // ];
  int currentIndex = 0;
  //var _scrollController;
  final _scrollController = ScrollController();
  final _pageController = PageController(initialPage: 0, keepPage: false);
  @override
  void initState() {
    // TODO: implement initState

    //_pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, orderProvider, child) {
      return WillPopScope(
        onWillPop: () async {
          if (currentIndex == 1) {
            setState(() {
              currentIndex = 0;
            });
            changePage(currentIndex);
            return false;
          } else if (currentIndex == 2) {
            // setState(() {
            //   currentIndex = 1;
            // });
            // changePage(currentIndex);
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          backgroundColor: kcBgHome2,
          body: NestedScrollView(
            //floatHeaderSlivers: true,
            controller: _scrollController,
            //physics: const NeverScrollableScrollPhysics(),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              //print(innerBoxIsScrolled);
              return [
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    automaticallyImplyLeading: currentIndex != 2,
                    //leading: ,
                    //forceElevated: innerBoxIsScrolled,
                    title: Text(
                      pagesTitle[currentIndex],
                      style: kwtextStyleRD(
                        c: kcWhite,
                        fs: 17,
                        fw: FontWeight.w600,
                      ),
                    ),
                    centerTitle: true,
                    expandedHeight:
                        110.h, // - MediaQuery.of(context).padding.top,
                    floating: true,
                    pinned: true,
                    // snap: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Spacer(
                                flex: 8,
                              ),
                              Expanded(
                                flex: 2,
                                child: pagePoint(0),
                              ),
                              Expanded(
                                flex: 15,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.w),
                                  child: Divider(
                                    color: kcHintTextSearch,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: pagePoint(1),
                              ),
                              Expanded(
                                flex: 15,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.w),
                                  child: Divider(
                                    color: kcHintTextSearch,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: pagePoint(2),
                              ),
                              Spacer(
                                flex: 8,
                              )
                            ],
                          ),
                          gaphr(h: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(
                                flex: 1,
                              ),
                              Expanded(
                                flex: 10,
                                child: Text(
                                  pagesTitle[0],
                                  style: kwtextStyleRD(
                                      fs: 12,
                                      c: kcWhite,
                                      fw: FontWeight.w600,
                                      h: 1.14),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const Spacer(
                                flex: 1,
                              ),
                              Expanded(
                                flex: 10,
                                child: Text(
                                  pagesTitle[1],
                                  style: kwtextStyleRD(
                                      fs: 12,
                                      c: kcWhite,
                                      fw: FontWeight.w600,
                                      h: 1.14),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const Spacer(
                                flex: 1,
                              ),
                              Expanded(
                                flex: 10,
                                child: Text(
                                  pagesTitle[2],
                                  style: kwtextStyleRD(
                                      fs: 12,
                                      c: kcWhite,
                                      fw: FontWeight.w600,
                                      h: 1.14),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const Spacer(
                                flex: 1,
                              ),
                            ],
                          ),
                          gaphr()
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: PageView(
              // itemCount: pages.length,
              // itemBuilder: ((context, index) {
              //   return pages[index];
              // }),
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              children: [
                BookAppointmentTab(
                    changePage: changePage,
                    patient: Provider.of<PatientProvider>(context).patient!),
                PaymentTab(
                    changePage: changePage,
                    orderService: orderProvider.orderService),
                const FinishedTab(),
              ],
            ),
          ),
        ),
      );
    });
  }

  void changePage(int index) {
    // _pageController.jumpToPage(index);
    _scrollController.jumpTo(0);
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn);
  }

  void setProvider(BuildContext context, OrderService orderService) {
    Provider.of<OrderProvider>(context, listen: false)
        .updateOrderService(orderService);
  }

  SizedBox pagePoint(int index) {
    return SizedBox(
      width: 17,
      height: 17,
      child: Stack(
        children: [
          Center(
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: kcHintTextSearch,
              ),
            ),
          ),
          Opacity(
            opacity: currentIndex == index ? 1 : 0,
            child: Image.asset(
              'assets/icons/tick.png',
              //height: 17,
            ),
          )
        ],
      ),
    );
  }
}
