import 'package:flutter/material.dart';

class BottomNavigator extends StatelessWidget {
  const BottomNavigator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined), label: "Báo Cáo"),
        BottomNavigationBarItem(icon: Icon(Icons.message), label: "Liên Hệ"),
        BottomNavigationBarItem(icon: Icon(Icons.home, size: 45), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.message), label: "Xét Nghiệm"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Cá Nhân")
      ],
      // currentIndex: _selectedIndex,
      // selectedItemColor: Colors.amber[800],
      // onTap: _onItemTapped,
    );
  }
}
