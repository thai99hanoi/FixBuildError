import 'package:flutter/material.dart';

import 'components/NavSideBar.dart';

class ReportScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       backgroundColor: Color.fromRGBO(78, 159, 193, 1),
       title: Text("BÁO CÁO SỨC KHOẺ HÀNG NGÀY"),
     ),
     body: Container(
       child: Text("Report Page"),
     ),
       drawer: NavDrawer());

  }

}