import 'package:flutter/material.dart';
import 'package:navi/utility/signout.dart';

class MainCompany extends StatefulWidget {
  @override
  _MainCompanyState createState() => _MainCompanyState();
}

class _MainCompanyState extends State<MainCompany> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('main company'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app), onPressed: () => signOutProcess(context))
        ],
      ),
    );
  }
}
