import 'package:account_management_app/pages/home_page.dart';
import 'package:account_management_app/widgets/ok_custom_painter.dart';
import 'package:flutter/material.dart';

//progress_tag
class TransactionCompletePage extends StatefulWidget {
  @override
  _TransactionCompletePageState createState() =>
      _TransactionCompletePageState();
}

class _TransactionCompletePageState extends State<TransactionCompletePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  Animation<double> _okAnimation;
  Animation<double> _tranlateAnimation;
  Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _okAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        curve: Interval(0.0, 0.15),
        parent: _animationController,
      ),
    );

    _tranlateAnimation = Tween<double>(
      begin: 1.0,
      end: 0.1,
    ).animate(
      CurvedAnimation(
        curve: Interval(0.15, 0.45),
        parent: _animationController,
      ),
    );

    _textAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        curve: Interval(0.45, 0.70),
        parent: _animationController,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AnimatedBuilder(
                animation: _tranlateAnimation,
                builder: (BuildContext context, Widget child) {
                  return SizedBox(
                    height: (size.height * 0.61) * _tranlateAnimation.value,
                  );
                },
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Hero(
                  tag: 'progress_tag',
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Container(
                      width: 80,
                      height: 80,
                      child: CustomPaint(
                        painter: OkProgressPainter(animation: _okAnimation),
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedBuilder(
                animation: _textAnimation,
                builder: (BuildContext context, Widget child) {
                  return Container(
                    height: _textAnimation.value * 120,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 30),
                      child: Container(
                        child: Text(
                          'Transaction\ncompleted',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: Container(
                  child: Text(
                    'Zofia Placa should receive the money within the next 24 hours.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF748DA7),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              _buildButtonDone(context),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      'Details',
                      style: TextStyle(
                        fontSize: 22,
                        color: Color(0xFF7C93AB),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildButtonDone(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: RaisedButton(
        padding: EdgeInsets.zero,
        onPressed: () => Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            opaque: true,
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) {
              final _parent =
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut);
              return SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0.0, -1.0),
                  end: Offset.zero,
                ).animate(_parent),
                child: HomePage(),
              );
            },
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            color: maincolor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            'DONE',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
