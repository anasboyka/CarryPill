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
  int currentIndex = 2;
  //var _scrollController;
  final _scrollController = ScrollController();
  final _pageController = PageController(initialPage: 2, keepPage: false);
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
    return Scaffold(
      backgroundColor: kcBgHome2,
      body: NestedScrollView(
        //floatHeaderSlivers: true,
        controller: _scrollController,
        //physics: const NeverScrollableScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          print(innerBoxIsScrolled);
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
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
                expandedHeight: 110.h, // - MediaQuery.of(context).padding.top,
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
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
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
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
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
          //physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          children: [
            BookAppointmentTab(changePage: changePage),
            PaymentTab(changePage: changePage),
            const FinishedTab(),
          ],
        ),
        // physics: PageScrollPhysics(),
        // slivers: [
        //   SliverAppBar(
        //     title: Text(
        //       pages[currentIndex],
        //       style: kwtextStyleRD(
        //         c: kcWhite,
        //         fs: 17,
        //         fw: FontWeight.w600,
        //       ),
        //     ),
        //     centerTitle: true,
        //     expandedHeight: 110.h, // - MediaQuery.of(context).padding.top,
        //     floating: true,
        //     pinned: true,
        //     flexibleSpace: FlexibleSpaceBar(
        //       background: Column(
        //         mainAxisAlignment: MainAxisAlignment.end,
        //         children: [
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               const Spacer(
        //                 flex: 8,
        //               ),
        //               Expanded(
        //                 flex: 2,
        //                 child: pagePoint(0),
        //               ),
        //               Expanded(
        //                 flex: 15,
        //                 child: Padding(
        //                   padding: EdgeInsets.symmetric(horizontal: 4.w),
        //                   child: Divider(
        //                     color: kcHintTextSearch,
        //                   ),
        //                 ),
        //               ),
        //               Expanded(
        //                 flex: 2,
        //                 child: pagePoint(1),
        //               ),
        //               Expanded(
        //                 flex: 15,
        //                 child: Padding(
        //                   padding: EdgeInsets.symmetric(horizontal: 4.w),
        //                   child: Divider(
        //                     color: kcHintTextSearch,
        //                   ),
        //                 ),
        //               ),
        //               Expanded(
        //                 flex: 2,
        //                 child: pagePoint(2),
        //               ),
        //               Spacer(
        //                 flex: 8,
        //               )
        //             ],
        //           ),
        //           gaphr(h: 8),
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               const Spacer(
        //                 flex: 1,
        //               ),
        //               Expanded(
        //                 flex: 10,
        //                 child: Text(
        //                   pages[0],
        //                   style: kwtextStyleRD(
        //                       fs: 12,
        //                       c: kcWhite,
        //                       fw: FontWeight.w600,
        //                       h: 1.14),
        //                   textAlign: TextAlign.center,
        //                 ),
        //               ),
        //               const Spacer(
        //                 flex: 1,
        //               ),
        //               Expanded(
        //                 flex: 10,
        //                 child: Text(
        //                   pages[1],
        //                   style: kwtextStyleRD(
        //                       fs: 12,
        //                       c: kcWhite,
        //                       fw: FontWeight.w600,
        //                       h: 1.14),
        //                   textAlign: TextAlign.center,
        //                 ),
        //               ),
        //               const Spacer(
        //                 flex: 1,
        //               ),
        //               Expanded(
        //                 flex: 10,
        //                 child: Text(
        //                   pages[2],
        //                   style: kwtextStyleRD(
        //                       fs: 12,
        //                       c: kcWhite,
        //                       fw: FontWeight.w600,
        //                       h: 1.14),
        //                   textAlign: TextAlign.center,
        //                 ),
        //               ),
        //               const Spacer(
        //                 flex: 1,
        //               ),
        //             ],
        //           ),
        //           gaphr()
        //         ],
        //       ),
        //     ),
        //   ),
        //   SliverToBoxAdapter(
        //     child: PageView(
        //       //physics: const NeverScrollableScrollPhysics(),
        //       children: [
        //         BookAppointmentTab(),
        //         PaymentTab(),
        //         FinishedTab(),
        //       ],
        //     ),
        //   )
        // ],
      ),
    );
  }

  void changePage(int index) {
    // _pageController.jumpToPage(index);
    _scrollController.jumpTo(0);
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn);
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
