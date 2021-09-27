import 'package:flutter/material.dart';

import 'chat_list_user.dart';
import 'new_home.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
  }

class _MainScreenState extends State<MainScreen>{
  int pageIndex = 0;
  List<Widget> pageList = <Widget>[
    homeScreen(),
    ListUser(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (value){
          setState((){
            pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.analytics_outlined), label: "Báo Cáo"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Liên Hệ"),
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 45), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Xét Nghiệm"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Cá Nhân")
        ],
      ),
    );
  }

  }