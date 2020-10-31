import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;
import 'package:account_management_app/pages/home_page.dart';

class LoadingProgressPainter extends CustomPainter {
  final Animation<double> animation;

  LoadingProgressPainter({@required this.animation})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = maincolor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final circlePath = Path();
    circlePath.addArc(
        Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2),
          height: size.height,
          width: size.width,
        ),
        vector.radians(-90),
        vector.radians(300 * animation.value));
    canvas.drawPath(circlePath, paint);
  }

  @override
  bool shouldRepaint(LoadingProgressPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(LoadingProgressPainter oldDelegate) => false;
}
