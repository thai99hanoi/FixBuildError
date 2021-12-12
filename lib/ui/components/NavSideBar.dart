import 'dart:math';

import 'package:flutter/material.dart';
import 'package:heath_care/networks/auth.dart';
import 'package:heath_care/repository/user_repository.dart';
import 'package:heath_care/ui/change_password.dart';
import 'package:heath_care/ui/login_screen.dart';
import 'package:heath_care/ui/send_request.dart';
import 'package:heath_care/ui/user_guilder.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _NavDrawer();
}

class _NavDrawer extends State<NavDrawer> {
  Future logout() async {
    try {
      await Provider.of<Auth>(context, listen: false).logout();
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
            decoration: BoxDecoration(
              color: new Color.fromRGBO(107, 157, 177, 1.0),
            ),
            child:
                // Image.asset("assets/images/Health Care System-logos_white.png"),
                ClipRRect(
                    child: Image.asset(
                        "assets/images/Health Care System-logos_white.png",
                        width: 200,
                        height: 100,
                        fit: BoxFit.fill)),
          ),
          ListTile(
            leading: Icon(Icons.security_outlined),
            title: Text('Thay đổi mật khẩu'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.help_center_outlined),
            title: Text('Liên hệ hỗ trợ'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SendRequest()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Hướng dẫn sử dụng'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserGuilderScreen()),
              )
            },
          ),
          ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text('Đăng xuất'),
              onTap: () => {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text(
                          'Đăng xuất',
                          style: TextStyle(color: Colors.blue),
                        ),
                        content: Text("Bạn có muốn đăng xuất"),
                        actions: <Widget>[
                          // ignore: deprecated_member_use
                          FlatButton(
                            child: Text('Không'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            child: Text('Đăng xuất'),
                            onPressed: () {
                              logout();
                            },
                          )
                        ],
                      ),
                    )
                  }
              // onTap: () => {logout()},
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
