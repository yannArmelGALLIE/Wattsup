import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wattsup/utils/theme/colors.dart';

class CircleProgress extends CustomPainter {
  final strokeCircle = 18.0;
  double currentProgress;

  CircleProgress(this.currentProgress);

  @override
  void paint(Canvas canvas, Size size) {
    Paint circle =
        Paint()
          ..strokeWidth = strokeCircle
          ..color = TColors.secondary
          ..style = PaintingStyle.stroke;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = size.width / 2 - strokeCircle / 2;
    canvas.drawCircle(center, radius, circle);

    Color arcColor;
    if (currentProgress < 50) {
      arcColor = TColors.success;
    } else if (currentProgress < 90) {
      arcColor = TColors.warning;
    } else {
      arcColor = TColors.error;
    }

    Paint animationArc =
        Paint()
          ..strokeWidth = 15
          ..color = arcColor
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    double angle = 2 * pi * (currentProgress / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi / 2,
      angle,
      false,
      animationArc,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
