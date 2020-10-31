import 'package:account_management_app/pages/transaction_completed_page.dart';
import 'package:account_management_app/widgets/loading_custom_painter.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController _rotateController;

  Animation<Offset> _slideAnimation;
  Animation<double> _fadeAnimationIn;
  Animation<double> _fadeAnimationOut;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        curve: Interval(0.0, 0.10),
        parent: _animationController,
      ),
    );

    _fadeAnimationIn = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        curve: Interval(0.50, 0.75),
        parent: _animationController,
      ),
    );

    _fadeAnimationOut = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        curve: Interval(0.20, 0.50),
        parent: _animationController,
      ),
    );

    TickerFuture tickerFuture = _rotateController.repeat();
    tickerFuture.timeout(
      Duration(seconds: 1 * 7),
      onTimeout: () {
        _rotateController.forward(from: 0);
        _rotateController.stop(canceled: true);
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 800),
            pageBuilder: (context, animation, secondaryAnimation) =>
                TransactionCompletePage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final curvedAnimation =
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut);

              return SlideTransition(
                position:
                    Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
                        .animate(curvedAnimation),
                child: child,
              );
            },
          ),
        );
      },
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _rotateController.dispose();

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
                            Stack(
                              children: [
                                AnimatedBuilder(
                                  animation: _animationController,
                                  builder:
                                      (BuildContext context, Widget child) {
                                    return Opacity(
                                      opacity: _fadeAnimationOut.value,
                                      child: Icon(
                                        Icons.fingerprint,
                                        size: 80,
                                      ),
                                    );
                                  },
                                ),
                                RotationTransition(
                                  turns: Tween(begin: 0.0, end: 1.0)
                                      .animate(_rotateController),
                                  child: Hero(
                                    tag: 'progress_tag',
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      child: CustomPaint(
                                        painter: LoadingProgressPainter(
                                            animation: _fadeAnimationIn),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            AnimatedBuilder(
                              animation: _fadeAnimationOut,
                              builder: (BuildContext context, Widget child) {
                                return Opacity(
                                  opacity: _fadeAnimationOut.value,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 25),
                                    child: Text(
                                      'Touch fingerprint sensor',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xFF748DA7),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            Spacer(),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  child: FlatButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: Color(0xFF748DA7),
                                        ),
                                      )),
                                ),
                              ),
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
                      'It might take some time',
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
