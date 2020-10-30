import 'package:account_management_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController _animationControllerFadeInFadeOut;

  Animation<Offset> _slideAnimation;
  Animation<double> _fadeAnimationIn;
  Animation<double> _fadeAnimationOut;

  Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _animationControllerFadeInFadeOut =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));

    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        curve: Interval(0.0, 0.25),
        parent: _animationController,
      ),
    );

    _fadeAnimationOut = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        curve: Interval(0.25, 0.50),
        parent: _animationController,
      ),
    );

    _fadeAnimationIn = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        curve: Interval(0.25, 0.75),
        parent: _animationController,
      ),
    );

    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(_animationControllerFadeInFadeOut);

    _animationController.addListener(_onListener);

    _animationControllerFadeInFadeOut.addListener(_onFadeListener);
    _animationController.forward();
  }

  void _onFadeListener() {
    if (_animationControllerFadeInFadeOut.status == AnimationStatus.completed) {
      _animationControllerFadeInFadeOut.reverse();
    }
  }

  void _onListener() {
    if (_animationController.status == AnimationStatus.completed) {
      _animationControllerFadeInFadeOut.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationController.removeListener(_onListener);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: AnimatedBuilder(
                animation: _animationController,
                builder: (BuildContext context, Widget child) =>
                    SlideTransition(
                      position: _slideAnimation,
                      child: Container(
                        height: size.height * 0.5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          ),
                        ),
                        child: Column(
                          children: [
                            _textFadeAnimation(),
                            RaisedButton(
                              onPressed: () {
                                _animationController.forward(from: 0.0);
                              },
                              child: Text('press'),
                            )
                          ],
                        ),
                      ),
                    )),
          )
        ],
      ),
    );
  }

  Stack _textFadeAnimation() {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget child) {
            return Opacity(
              opacity: _fadeAnimationOut.value,
              child: Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Confirm to check out',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Confirm using biometric credential',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF7C93AB),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget child) {
            return Opacity(
              opacity: _fadeAnimationIn.value,
              child: Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Processing',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'It might take some',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF7C93AB),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class OkProgressPainter extends CustomPainter {
  final Animation<double> animation;

  OkProgressPainter({@required this.animation}) : super(repaint: animation);

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
  bool shouldRepaint(OkProgressPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(OkProgressPainter oldDelegate) => false;
}
