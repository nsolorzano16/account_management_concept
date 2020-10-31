import 'package:account_management_app/pages/checkout_page.dart';
import 'package:account_management_app/pages/home_page.dart';
import 'package:flutter/material.dart';

class ReviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBackButton(context),
            _buildAmount(),
            _buildText(
                'Zofia Placa requested 28,00 PLN from you. Request has no message.'),
            const SizedBox(
              height: 15,
            ),
            _buildTitleBold('Recipient'),
            _buildItemZofiaPlaca(),
            const SizedBox(
              height: 15,
            ),
            _buildTitleBold('Your Account'),
            const SizedBox(
              height: 15,
            ),
            _buildAccountNumber(),
            _buildButtonPay(context),
            Align(
              alignment: Alignment.center,
              child: FlatButton(
                onPressed: () {},
                child: Text(
                  'Decline',
                  style: TextStyle(
                    fontSize: 22,
                    color: Color(0xFF7C93AB),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding _buildButtonPay(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: RaisedButton(
        padding: EdgeInsets.zero,
        onPressed: () => Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: animation,
              child: child,
            ),
            pageBuilder: (context, animation, secondaryAnimation) =>
                CheckoutPage(),
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
            'PAY 28,00 PLN',
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

  Padding _buildAccountNumber() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.grey[350],
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Color(0xFFB51A92),
                radius: 15,
                child: Icon(
                  Icons.receipt,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              '120 320 . . . 000 890',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            FlatButton(
              onPressed: () {},
              child: Text(
                'Change',
                style: TextStyle(
                  color: Color(0xFF7C93AB),
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding _buildItemZofiaPlaca() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Container(
        height: 40,
        width: 140,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: CircleAvatar(
                backgroundColor: Colors.grey[400],
                child: Text(
                  'ZP',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Text(
              'Zofia Placa',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding _buildText(String text) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 17,
              color: Colors.grey[600],
            ),
          )
        ],
      ),
    );
  }

  Padding _buildAmount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '- 28,00 PLN',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          FlatButton(
            onPressed: () {},
            child: Text(
              'Edit',
              style: TextStyle(color: Color(0xFF7C93AB), fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildBackButton(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.grey[800],
            ),
            onPressed: () => Navigator.pop(context)),
      ),
    );
  }

  Widget _buildTitleBold(String text) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
