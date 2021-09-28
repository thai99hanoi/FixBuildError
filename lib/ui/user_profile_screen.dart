import 'package:flutter/material.dart';

import 'components/NavSideBar.dart';

class UserProfileScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(78, 159, 193, 1),
          title: Text("HỒ SƠ"),
        ),
        body: Container(
          child: Text("PROFILE Page"),
        ),
        drawer: NavDrawer());

  }

}