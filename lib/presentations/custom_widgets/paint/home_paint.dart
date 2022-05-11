import '../../../constants/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTabHeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // print('${size.height} size');
    // print('${size.height * hPercent} draw');
    final h = size.height;
    final w = size.width;
    Paint paint = Paint();
    Path ovalheader = Path();
    ovalheader.moveTo(0, 0);
    ovalheader.lineTo(0, 205.h);
    // ovalheader.quadraticBezierTo(
    //     w * 0.25, h * mpPercent, w * 0.5, h * mpPercent);
    // ovalheader.quadraticBezierTo(w * 0.75, h * mpPercent, w, h * hPercent);
    ovalheader.quadraticBezierTo(w * 0.25, 183.h, w * 0.5, 183.h);
    ovalheader.quadraticBezierTo(w * 0.75, 183.h, w, 205.h);
    ovalheader.lineTo(w, 0);
    ovalheader.close();
    paint.color = kcPrimary;
    canvas.drawPath(ovalheader, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate != this;
  }
}
