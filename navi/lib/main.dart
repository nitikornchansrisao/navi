import 'package:flutter/material.dart';
import 'package:navi/screen/home.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title : "Food",
      home: Home(),
      
    );
  }
}