import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:navi/utility/my_style.dart';
import 'package:navi/utility/normal_dialog.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String chooseType, name, username, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: <Widget>[
          myLogo(),
          MyStyle().mySizeBox(),
          showAppName(),
          MyStyle().mySizeBox(),
          nameForm(),
          MyStyle().mySizeBox(),
          usernameForm(),
          MyStyle().mySizeBox(),
          passwordForm(),
          MyStyle().mySizeBox(),
          userRadio(),
          shopRadio(),
          registerButton(),
        ],
      ),
    );
  }

  Widget registerButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 250,
          child: RaisedButton(
            color: MyStyle().darkColor,
            onPressed: () {
              print(
                  'name = $name, user = $username, password = $password, chooseType = $chooseType');
              if (name == null || name.isEmpty ){
                normalDialog(context, 'Please enter name');
              }
              else if(username == null || username.isEmpty ){
                normalDialog(context, 'Please enter username');
              }
              else if(password == null || password.isEmpty){
                normalDialog(context, 'Please enter password');
              }    
              else if(chooseType == null){
                normalDialog(context, 'Please enter type');
              }else{
                checkUser();
              }
            },
            child: Text(
              'Register',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

    Future <Null> checkUser()async{
      String url = 'http://192.168.1.39/parttime/checkUser.php?isAdd=true&username=$username';

      try {
        Response response = await Dio().get(url);
        if(response.toString() == 'null'){
          registerThread();
        }
        else{
          normalDialog(context, 'This user is "$username" already used.');
        }
      } catch (e) {

      }

    }


    Future<Null> registerThread()async{
      String url = 'http://192.168.1.39192.168.10.115/parttime/userRegister.php?name=$name&username=$username&password=$password&choosetype=$chooseType';

      try {
        Response response = await Dio().get(url);
        print('res = $response');

        if(response.toString() == 'true'){
          Navigator.pop(context);
        }else{
          normalDialog(context, 'Cannot Register!');
        }
      } catch (e) {
      }

    }


  Widget userRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 250,
            child: Row(children: <Widget>[
              Radio(
                value: 'User',
                groupValue: chooseType,
                onChanged: (value) {
                  setState(() {
                    chooseType = value;
                  });
                },
              ),
              Text(
                'Part-Time',
                style: TextStyle(color: MyStyle().darkColor),
              ),
            ]),
          ),
        ],
      );

  Widget shopRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 250,
            child: Row(children: <Widget>[
              Radio(
                value: 'Shop',
                groupValue: chooseType,
                onChanged: (value) {
                  setState(() {
                    chooseType = value;
                  });
                },
              ),
              Text(
                'Company',
                style: TextStyle(color: MyStyle().darkColor),
              ),
            ]),
          ),
        ],
      );

  Widget nameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 250,
            child: TextField(
              onChanged: (value) => name = value.trim(),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.face,
                    color: MyStyle().darkColor,
                  ),
                  labelText: 'Name :',
                  labelStyle: TextStyle(color: MyStyle().darkColor),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().darkColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().primaryColor),
                  )),
            ),
          ),
        ],
      );

  Widget usernameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 250,
            child: TextField(
              onChanged: (value) => username = value.trim(),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.account_box,
                    color: MyStyle().darkColor,
                  ),
                  labelText: 'Username :',
                  labelStyle: TextStyle(color: MyStyle().darkColor),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().darkColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().primaryColor),
                  )),
            ),
          ),
        ],
      );

  Widget passwordForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 250,
            child: TextField(
              onChanged: (value) => password = value.trim(),
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
          ),
        ],
      );

  Row showAppName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        MyStyle().showTitle('Part-Time'),
      ],
    );
  }

  Widget myLogo() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MyStyle().showLogo(),
        ],
      );
}
