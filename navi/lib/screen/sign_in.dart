import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:navi/model/user_model.dart';
import 'package:navi/screen/main_company.dart';
import 'package:navi/screen/main_user.dart';
import 'package:navi/utility/my_style.dart';
import 'package:navi/utility/normal_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String username, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                MyStyle().showLogo(),
                MyStyle().mySizeBox(),
                MyStyle().showTitle('Part-Time'),
                MyStyle().mySizeBox(),
                userForm(),
                MyStyle().mySizeBox(),
                passwordForm(),
                MyStyle().mySizeBox(),
                loginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton() => Container(
        width: 100,
        child: RaisedButton(
          // color: MyStyle().darkColor,
          onPressed: () {
            if (username == null || username.isEmpty) {
              normalDialog(context, 'Please enter username');
            } else if (password == null || password.isEmpty) {
              normalDialog(context, 'Please enter password');
            } else {
              checkAuthen();
            }
          },
          padding: EdgeInsets.all(0),

          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(1.0, 0.0),
                colors: <Color>[
                  MyStyle().a,
                  MyStyle().b,
                  MyStyle().c,
                  MyStyle().d,
                  MyStyle().e,
                ],
              ),
            ),
            padding: EdgeInsets.all(25),
            child: Text(
              'Login',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      );

  Future<Null> checkAuthen() async {
    String url =
        'http://192.168.1.39/parttime/checkUser.php?isAdd=true&username=$username';
    try {
      Response response = await Dio().get(url);
      print('res = $response');

      // อ่านภาษาไทย
      var result = json.decode(response.data);
      print('result = $result');

      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);
        if (password == userModel.password) {
          String chooseType = userModel.choosetype;
          if (chooseType == 'User') {
            routeTuService(MainUser(), userModel);
          } else if (chooseType == 'Shop') {
            routeTuService(MainCompany(),userModel);
          } else{
            normalDialog(context, 'Error');
          }
        } else {
          normalDialog(context, 'Password Faild');
        }
      }
    } catch (e) {}
  }

  Future<Null> routeTuService(Widget myWidget, UserModel userModel) async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id', userModel.id);
    preferences.setString('choosetype', userModel.choosetype);
    preferences.setString('name', userModel.name);  


    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Widget userForm() => Container(
        width: 250,
        child: TextField(
          onChanged: (value) => username = value.trim(),
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.account_box,
                color: MyStyle().darkColor,
              ),
              labelText: 'User :',
              labelStyle: TextStyle(color: MyStyle().darkColor),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().darkColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().primaryColor),
              )),
        ),
      );
  Widget passwordForm() => Container(
        width: 250,
        child: TextField(
          onChanged: (value) => password = value.trim(),
          obscureText: true,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: MyStyle().darkColor,
              ),
              labelText: 'Password :',
              labelStyle: TextStyle(color: MyStyle().darkColor),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().darkColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().primaryColor),
              )),
        ),
      );
}
