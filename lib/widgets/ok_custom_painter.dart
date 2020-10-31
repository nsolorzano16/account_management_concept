import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;

class OkProgressPainter extends CustomPainter {
  final Animation<double> animation;

  OkProgressPainter({@required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromRGBO(57, 144, 106, 1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    final circlePath = Path();
    circlePath.addArc(
        Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2),
          height: size.height,
          width: size.width,
        ),
        vector.radians(-90.0),
        vector.radians(360.0 * animation.value));
    final leftLine = size.width * 0.2;
    final rigthLine = size.width * 0.3;
    final leftPercent = animation.value > 0.5 ? 1.0 : animation.value / 0.5;
    final rigthPercent =
        animation.value < 0.5 ? 0.0 : (animation.value - 0.5) / 0.5;
    canvas.save();
    canvas.translate(size.width / 3, size.height / 2);
    canvas.rotate(
      vector.radians(-45),
    );
    canvas.drawLine(Offset.zero, Offset(0.0, leftLine * leftPercent), paint);
    canvas.drawLine(Offset(0.0, leftLine),
        Offset(rigthLine * rigthPercent, leftLine), paint);
    canvas.restore();

    canvas.drawPath(circlePath, paint);
  }

  @override
  bool shouldRepaint(OkProgressPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(OkProgressPainter oldDelegate) => false;
}
