import 'package:account_management_app/pages/home_page.dart';
import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onTap;

  const CustomFloatingActionButton({Key key, @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: EdgeInsets.all(10),
          width: 200,
          height: 60,
          decoration: BoxDecoration(
            color: maincolor,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 18,
              ),
              Icon(
                Icons.add,
                color: Colors.white,
              ),
              Text(
                'TRANSACTION',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
