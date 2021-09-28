import 'package:flutter/material.dart';

import 'components/NavSideBar.dart';

class TestScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(78, 159, 193, 1),
          title: Text("KẾT QUẢ XÉT NGHIỆM"),
        ),
        body: Container(
          child: Text("TEST Page"),
        ),
        drawer: NavDrawer());

  }

}