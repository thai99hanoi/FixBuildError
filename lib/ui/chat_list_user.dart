import 'package:flutter/material.dart';
import 'package:heath_care/model/user.dart';
import 'package:heath_care/networks/api_base_helper.dart';
import 'package:heath_care/networks/auth.dart';
import 'package:heath_care/repository/user_repository.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ListUser extends StatelessWidget {

  Future<List<User>?> getUserOnline = UserRepository().getUserOnline();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(78, 159, 193, 1),
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
                      new FutureBuilder<List<User>?>(
                          future: getUserOnline,
                          builder: (context, snapshot){
                            List<User>? users = snapshot.data;
                            if (snapshot.hasData) {
                              return Text(users.toString());
                            } else {
                              return CircularProgressIndicator();
                            }
                          }
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color.fromRGBO(78, 159, 193, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
            backgroundColor: Color.fromRGBO(78, 159, 193, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
            backgroundColor: Color.fromRGBO(78, 159, 193, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Color.fromRGBO(78, 159, 193, 1),
          ),
        ],
        // currentIndex: _selectedIndex,
        // selectedItemColor: Colors.amber[800],
        // onTap: _onItemTapped,
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
                Navigator.of(context).pushReplacementNamed("/");
                Provider.of<Auth>(context, listen: false).logout();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

    );
  }
}
