import 'package:flutter/material.dart';
import 'package:heath_care/model/user.dart';
import 'package:heath_care/repository/user_repository.dart';

import 'chat_conversation.dart';
import 'components/Bottom_Navigator.dart';
import 'components/NavSideBar.dart';

// ignore: must_be_immutable
class ListUser extends StatefulWidget {
  // new FutureBuilder<List<User>?>(
  // future: getUserOnline,
  // builder: (context, snapshot) {
  // List<User>? users = snapshot.data;
  // print(users!.toList().toString());
  // if (snapshot.hasData) {
  // return Text(users.toString());
  // } else {
  // return CircularProgressIndicator();
  // }
  // }),
  @override
  State<ListUser> createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  int _selectedIndex = 1;
  Future<List<User>?> _getUserOnline = UserRepository().getUserOnline();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(78, 159, 193, 1),
        title: Text('LIÊN HỆ HỖ TRỢ'),
      ),
      body: FutureBuilder<List<User>?>(
          future: _getUserOnline,
          builder: (context, snapshot) {
            List<User>? users = snapshot.data;
            if (snapshot.hasData) {
              return Container(
                child: ListView.builder(
                    itemCount: users!.length,
                    itemBuilder: (BuildContext context, int index) => InkWell(
                          onTap: () {
                            Route route = MaterialPageRoute(
                                builder: (context) => ConversationChat());
                            Navigator.push(context, route);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20 * 0.75),
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 24,
                                      backgroundImage:
                                          AssetImage('assets/images/img_1.png'),
                                    ),
                                    if ('${users[index].isOnline}' == '1')
                                      Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: Container(
                                          height: 16,
                                          width: 16,
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors.white, width: 3),
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${users[index].username}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Opacity(
                                        opacity: 0.64,
                                        child: Text(
                                          "Last Message Here!",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                                Opacity(
                                  opacity: 0.64,
                                  child: Text("3m ago"),
                                )
                              ],
                            ),
                          ),
                        )),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
        drawer: NavDrawer()
    );
  }
}
