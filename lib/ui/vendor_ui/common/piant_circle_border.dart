
import 'dart:math';

import 'package:flutter/material.dart';

import '../../../config/ps_colors.dart';

double deg2rad(double deg) => deg * pi / 180;

double rad2deg(double rad) => rad * 180 / pi;

class PaintCircleBorder extends CustomPainter {

  PaintCircleBorder({
    this.borderThinckness,
    this.leftColor,
    this.rightColor
  });
  final double? borderThinckness;
  final Color? leftColor;
  final Color? rightColor;
  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);

    final Paint paintLeft = Paint()
      ..color = leftColor ?? PsColors.achromatic50
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderThinckness ?? 3.5;

    final Paint paintRight = Paint()
      ..color = rightColor ?? PsColors.achromatic50.withAlpha(50)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderThinckness ?? 3.5;



    ///Right
    canvas.drawArc(
        Rect.fromCenter(center: center, width: size.width, height: size.height),
        deg2rad(270),
        deg2rad(180),
        false,
        paintRight);

    ///Left
    canvas.drawArc(
        Rect.fromCenter(center: center, width: size.width, height: size.height),
        deg2rad(90),
        deg2rad(180),
        false,
        paintLeft);

    // ///TopLeft
    // canvas.drawArc(
    //     Rect.fromCenter(center: center, width: size.width, height: size.height),
    //     deg2rad(180),
    //     deg2rad(90),
    //     false,
    //     paintLeft);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}