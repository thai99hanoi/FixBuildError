import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("   FOR COVID PATIENT AT HOME",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'RobotoMono',
                            color: Colors.white)),
                    Text("HEALTH CARE",
                        style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                    Text("SYSTEM",
                        style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                  ],
                ),
              )
              // Image.asset("assets/images/Health Care System-logos_white.png"),
              //     Container(
              //   width: 150,
              //   height: 200,
              //   child: ClipRRect(
              //       child: Image.asset(
              //           "assets/images/Health Care System-logos_white.png",
              //           fit: BoxFit.fill)),
              // ),
              ),
          ListTile(
            leading: Icon(Icons.security_outlined),
            title: Text('Thay ?????i m???t kh???u'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.help_center_outlined),
            title: Text('Li??n h??? h??? tr???'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SendRequest()),
              )
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.info_outline),
          //   title: Text('H?????ng d???n c??ch ly t???i nh??'),
          //   onTap: () => {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => UserGuilderScreen()),
          //     )
          //   },
          // ),
          ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text('????ng xu???t'),
              onTap: () => {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text(
                          '????ng xu???t',
                          style: TextStyle(color: Colors.blue),
                        ),
                        content: Text("B???n c?? mu???n ????ng xu???t"),
                        actions: <Widget>[
                          // ignore: deprecated_member_use
                          FlatButton(
                            child: Text('Kh??ng'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            child: Text('????ng xu???t'),
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
