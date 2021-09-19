import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'package:heath_care/ui/login_screen.dart';
import 'package:heath_care/networks/auth.dart';

class ListUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LIÊN HỆ HỖ TRỢ'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.20),
            child: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 23,
                      backgroundImage: AssetImage("assets/images/img_1.png"),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 16,
                        width: 16,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User Name',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Opacity(
                        opacity: 0.64,
                        child: Text(
                          'Last message is here!!!...',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.normal),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Opacity(
                    opacity: 0.64,
                    child: Text('3m ago'),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.messenger), label: "Liên hệ"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Trang Chủ"),
          BottomNavigationBarItem(icon: Icon(Icons.report), label: "Kết quả"),
          // BottomNavigationBarItem(icon: Icon(Icons.send_and_archive), label: "Báo cáo"),
          // BottomNavigationBarItem(icon: Icon(Icons.send_and_archive), label: "Báo cáo"),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Trang Chủ'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Hướng Dẫn SỬ Dụng Phần Mềm'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Đăng Xuất'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

    );
  }
}
