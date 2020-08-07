import 'package:flutter/material.dart';
import 'package:navi/screen/main_company.dart';
import 'package:navi/screen/main_user.dart';
import 'package:navi/screen/sign_in.dart';
import 'package:navi/screen/sign_up.dart';
import 'package:navi/utility/normal_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPrefreance();
  }

  Future<Null> checkPrefreance() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String choosetype = preferences.getString('choosetype');
      if (choosetype != null && choosetype.isNotEmpty) {
        if (choosetype == 'User') {
          routeToService(MainUser());
        } else if (choosetype == 'Shop') {
          routeToService(MainCompany());
        } else {
          normalDialog(context, 'Error');
        }
      }
    } catch (e) {}
  }

  void routeToService(Widget myWidget) {
    MaterialPageRoute route = MaterialPageRoute(builder: (context) => myWidget);
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: showDrawer(),
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            showHeadDrawer(),
            signInMenu(),
            signUpMenu(),
          ],
        ),
      );

  ListTile signInMenu() {
    return ListTile(
      leading: Icon(Icons.people),
      title: Text('Sign In'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => SignIn());
        Navigator.push(context, route);
      },
    );
  }

  ListTile signUpMenu() {
    return ListTile(
      leading: Icon(Icons.computer),
      title: Text('Sign Up'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => SignUp());
        Navigator.push(context, route);
      },
    );
  }

  UserAccountsDrawerHeader showHeadDrawer() {
    return UserAccountsDrawerHeader(
      accountName: Text('Guest'),
      accountEmail: Text('Please Login'),
    );
  }
}
