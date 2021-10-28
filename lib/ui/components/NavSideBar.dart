import 'dart:math';

import 'package:flutter/material.dart';
import 'package:heath_care/networks/auth.dart';
import 'package:heath_care/repository/user_repository.dart';
import 'package:heath_care/ui/login_screen.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _NavDrawer();
}

class _NavDrawer extends State<NavDrawer> {
  Future logout() async {
    try {
      await Provider.of<Auth>(context, listen: false).logout().then((value) => UserRepository().updateUserOnline(0));
      Route route = MaterialPageRoute(builder: (context) => LoginPage());
      Navigator.push(context, route);
    } catch (error) {
      var errorMessage = 'Please try again later';
      print(error.toString());
      _showerrorDialog(errorMessage);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {logout()},
          ),
        ],
      ),
    );
  }

  void _showerrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'An Error Occurs',
          style: TextStyle(color: Colors.blue),
        ),
        content: Text(message),
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }


}
