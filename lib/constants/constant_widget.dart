import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import 'constant_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const kwstyleb12 = TextStyle(
  fontSize: 12,
  color: Colors.black,
);

const kwstyleb14 = TextStyle(
  fontSize: 14,
  color: Colors.black,
);

const kwstyleb15 = TextStyle(
  fontSize: 15,
  color: Colors.black,
);

const kwstyleb16 = TextStyle(
  fontSize: 16,
  color: Colors.black,
);

const kwstyleb18 = TextStyle(
  fontSize: 18,
  color: Colors.black,
);

const kwstyleb20 = TextStyle(
  fontSize: 20,
  color: Colors.black,
);

const kwstyleHeader35 = TextStyle(
  fontSize: 35,
  color: Colors.black,
);

const kwstylew12 = TextStyle(
  fontSize: 12,
  color: Colors.white,
);

const kwstylew14 = TextStyle(
  fontSize: 14,
  color: Colors.white,
);

const kwstylew15 = TextStyle(
  fontSize: 15,
  color: Colors.white,
);

const kwstylew16 = TextStyle(
  fontSize: 16,
  color: Colors.white,
);

const kwstylew18 = TextStyle(
  fontSize: 18,
  color: Colors.white,
);

const kwstylew20 = TextStyle(
  fontSize: 20,
  color: Colors.white,
);

const kwstyleHeaderw35 = TextStyle(
  fontSize: 35,
  color: Colors.white,
);

const kwstyleHint16 = TextStyle(
  fontSize: 16,
  color: Color(0xFF9097A4),
);
const kwstyleHint15 = TextStyle(
  fontSize: 15,
  color: kcHintTextSearch,
);

const kwstyleBtn15 = TextStyle(
  fontSize: 15,
  color: kcWhite,
  fontWeight: FontWeight.w500,
);

const kwDivider = Divider(
  color: kcDivider,
  endIndent: 0,
  height: 0,
  indent: 0,
  thickness: 1,
);

const kwInset0 = EdgeInsets.zero;

//String
String dateformat(DateTime date, {String format = 'dd-MM-yyyy'}) {
  return DateFormat(format).format(date);
}

String dateformatText(DateTime date) {
  return DateFormat('d MMMM, yyyy').format(date);
}

String dateformatNumSlashI(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date);
}

String dateformatNumSlashD(DateTime date) {
  return DateFormat('yy/MM/dddd').format(date);
}

String dateformatNumDashI(DateTime date) {
  return DateFormat('dd-MM-yyyy').format(date);
}

String dateformatNumDashD(DateTime date) {
  return DateFormat('yy-MM-dddd').format(date);
}

TextStyle kwtextStyleRD(
    {double fs = 12,
    Color c = Colors.black,
    double? h,
    FontWeight? fw,
    String ff = 'SF Pro Text'}) {
  return TextStyle(
    fontFamily: ff,
    fontSize: fs.sp,
    color: c,
    height: h,
    fontWeight: fw,
  );
}

TextStyle kwtextStyleD(
    {double fs = 12, Color c = Colors.black, double? h, FontWeight? fw}) {
  return TextStyle(
    fontSize: fs,
    color: c,
    height: h,
    fontWeight: fw,
  );
}

SizedBox gapwr({double w = 20}) {
  return SizedBox(width: w.w);
}

SizedBox gaphr({double h = 20}) {
  return SizedBox(height: h.h);
}

SizedBox gapw({double w = 20}) {
  return SizedBox(width: w);
}

SizedBox gaph({double h = 20}) {
  return SizedBox(height: h);
}

Text textBtn15(
  String title, {
  TextStyle style = kwstyleBtn15,
}) {
  return Text(
    title,
    style: style,
  );
}

Divider divider({Color c = kcDivider, double t = 1}) {
  return Divider(
    color: c,
    thickness: t,
    endIndent: 0,
    height: 0,
    indent: 0,
  );
}

EdgeInsetsGeometry padSymR({double h = 20, double v = 0}) {
  return EdgeInsets.symmetric(horizontal: h.w, vertical: v.h);
}

EdgeInsetsGeometry padSym({h = 20, v = 0}) {
  return EdgeInsets.symmetric(horizontal: h, vertical: v);
}

EdgeInsetsGeometry padOnlyR({
  double l = 0,
  double t = 0,
  double r = 0,
  double b = 0,
}) {
  return EdgeInsets.only(left: l.w, top: t.h, right: r.w, bottom: b.h);
}

EdgeInsetsGeometry padOnly({
  double l = 0,
  double t = 0,
  double r = 0,
  double b = 0,
}) {
  return EdgeInsets.only(left: l, top: t, right: r, bottom: b);
}

BorderRadius borderRadiuscR({double r = 10}) {
  return BorderRadius.circular(r.r);
}

RoundedRectangleBorder cornerR({double r = 10}) {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(r.r),
  );
}

RoundedRectangleBorder corner({double r = 10}) {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(r),
  );
}

InputDecoration inputDecorationTextField(
    {String? hintText, bool isPassword = false}) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: const BorderSide(color: kcOutlineTextField),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: const BorderSide(color: kcOutlineTextField),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: const BorderSide(color: kcLightYellow, width: 2),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: const BorderSide(color: kcOutlineTextField),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: const BorderSide(color: Colors.red),
    ),
    contentPadding: const EdgeInsets.fromLTRB(20, 24, 12, 16),
    fillColor: Colors.white,
    filled: true,
    hintText: hintText,
    hintStyle: kwstyleHint16,
    suffixIcon: isPassword
        ? IconButton(
            onPressed: () {},
            icon: const Icon(Icons.visibility_off),
          )
        : null,
  );
}

Widget kwOrderReceivedStatusWidget = Column(
  children: [
    gaphr(h: 48.5),
    const SizedBox(
      height: 71,
      child: Icon(
        Icons.task_alt_rounded,
        color: kcOrange,
        size: 81,
      ),
    ),
    gaphr(h: 40),
  ],
);

Widget kwfindingDriverStatusWidget = Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    SizedBox(
      height: 159.5.h,
      child: FittedBox(
        fit: BoxFit.cover,
        child: Lottie.asset(
          'assets/lottie/loading.json',
          fit: BoxFit.fill,
        ),
      ),
    ),
  ],
);

Widget kwdriverToHospitalStatusWidget = Column(
  //crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    Padding(
      padding: EdgeInsets.only(right: 30.w),
      child: SizedBox(
        height: 159.5.h,
        width: double.infinity,
        child: Lottie.asset(
          'assets/lottie/delivery.json',
          fit: BoxFit.contain,
        ),
      ),
    ),
  ],
);

Widget kwdriverQueueStatusWidget = Column(
  //crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    gaphr(h: 12.5),
    SizedBox(
      height: 132.h,
      child: Lottie.asset(
        'assets/lottie/queue.json',
        fit: BoxFit.cover,
      ),
    ),
    gaphr(h: 15),
  ],
);

Widget kworderPreparingStatusWidget = Column(
  children: [
    gaphr(h: 20.5),
    SizedBox(
      height: 134.h,
      child: Lottie.asset(
        'assets/lottie/waiting.json',
        fit: BoxFit.cover,
      ),
    ),
    gaphr(h: 5),
  ],
);

Widget kwOutForDeliveryStatusWidget = Column(
  children: [
    gaphr(h: 20.5),
    SizedBox(
      height: 134.h,
      child: Lottie.asset(
        'assets/lottie/on_the_way.json',
        fit: BoxFit.cover,
      ),
    ),
    gaphr(h: 5),
  ],
);

Widget kworderArrivedStatusWidget = Column(
  children: [
    gaphr(h: 9.5),
    SizedBox(
      height: 150.h,
      child: Lottie.asset(
        'assets/lottie/arrived.json',
        fit: BoxFit.cover,
      ),
    ),
  ],
);
Widget kworderFinishedStatusWidget(String imageUrl) {
  return Column(
    children: [
      gaphr(h: 9.5),
      SizedBox(
        height: 150.h,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    ],
  );
}
