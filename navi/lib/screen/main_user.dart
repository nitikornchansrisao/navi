// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:navi/utility/signout.dart';
import 'package:navi/widget/information.dart';
import 'package:navi/widget/order_list_shop.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainUser extends StatefulWidget {
  @override
  _MainUserState createState() => _MainUserState();
}

class _MainUserState extends State<MainUser> {
  String nameUser;

  //Field
  Widget currentWidget = OrderListShop();

  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString('name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nameUser == null ? 'Main User' : '$nameUser login'),
 
      ),
      drawer: showDrawer(),
      body: currentWidget,
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            showHeadDrawer(),
            homeMenu(),
            foodMenu(),
            informationMenu(),
            signOutMenu(),
          ],
        ),
      );

  ListTile homeMenu() => ListTile(
        leading: Icon(Icons.home),
        title: Text('รายการอาหารที่สั่ง'),
        subtitle: Text('รายการที่ยังไม่ได้ทำ'),
        onTap: (){setState(() {
          currentWidget = OrderListShop();
        });
        Navigator.pop(context);
        },
      );
  ListTile foodMenu() => ListTile(
        leading: Icon(Icons.home),
        title: Text('รายการอาหาร'),
        subtitle: Text('รายการที่ยังไม่ได้ทำ'),
      );
  ListTile informationMenu() => ListTile(
        leading: Icon(Icons.info),
        title: Text('รายละอียดของร้าน'),
        subtitle: Text('รายละอียดของร้าน พร้อมEdit'),
        onTap: (){setState(() {
          currentWidget = Information();
        });
        Navigator.pop(context);
        },
      );
  ListTile signOutMenu() => ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text('Sign Out'),
        subtitle: Text('Sign Out'),
        onTap: () => signOutProcess(context),
      );

  UserAccountsDrawerHeader showHeadDrawer() {
    return UserAccountsDrawerHeader(
      accountName: Text('Guest'),
      accountEmail: Text('Please Login'),
    );
  }
}
