import 'dart:ui';

import 'package:account_management_app/pages/home_page.dart';
import 'package:account_management_app/pages/review_page.dart';
import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.31,
      width: double.infinity,
      child: Card(
        elevation: 2,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Zofia Placa',
                    style: TextStyle(
                      color: Color(0xFF212129),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '-28,00 PLN',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Container(
                child: Text(
                  'Incididunt nostrud et aliquip do nisi sint nostrud magna veniam adipisicing. Ex ut pariatur nulla deserunt. Anim culpa eiusmod cupidatat anim velit cillum nulla ex et in irure fugiat. Fugiat occaecat occaecat ',
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      'DECLINE',
                      style: TextStyle(
                        color: Color(0xFF7C93AB),
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            ReviewPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          final curvedAnimation = CurvedAnimation(
                              parent: animation, curve: Curves.easeInOut);

                          return SlideTransition(
                            position: Tween<Offset>(
                                    begin: Offset(0.0, 1.0), end: Offset.zero)
                                .animate(curvedAnimation),
                            child: child,
                          );
                        },
                      ),
                    ),
                    child: Text(
                      'REVIEW',
                      style: TextStyle(
                        color: maincolor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
