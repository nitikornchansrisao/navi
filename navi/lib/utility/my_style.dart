import 'package:flutter/material.dart';

class MyStyle {
  Color darkColor = Colors.blue[600];
  Color primaryColor = Colors.green[300];

  Color a = const Color.fromRGBO(78, 173, 253, 1);
  Color b = const Color.fromRGBO(70, 194, 230, 1);
  Color c = const Color.fromRGBO(67, 205, 218, 1);
  Color d = const Color.fromRGBO(62, 216, 206, 1);
  Color e = const Color.fromRGBO(55, 235, 187, 1);

  SizedBox mySizeBox() => SizedBox(
        width: 8,
        height: 16,
      );

  Text showTitle(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 24,
          color: Colors.green[800],
          fontWeight: FontWeight.bold,
        ),
      );

  Container showLogo() {
    return Container(
      width: 120,
      child: Image.asset('images/user.png'),
    );
  }

  Widget titleCenter(String string) {
    return Center(
      child: Text(
        string,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  MyStyle();
}
