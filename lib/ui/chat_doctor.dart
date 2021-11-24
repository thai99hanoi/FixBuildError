import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:heath_care/firebase/chat_firebase.dart';
import 'package:heath_care/model/user.dart';
import 'package:heath_care/repository/user_repository.dart';
import 'package:heath_care/ui/components/item_conversation.dart';

import 'components/NavSideBar.dart';
import 'components/item_user_online.dart';

class ChatDoctor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChatDoctorState();
}

class _ChatDoctorState extends State<ChatDoctor> {
  bool _buildOnlinePage = false;

  Future<List<User>?> _userOnline = new UserRepository().getPatient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(78, 159, 193, 1),
          title: Text('LIÊN HỆ HỖ TRỢ'),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTab(false, "TIN NHẮN"),
                SizedBox(
                  width: 16,
                ),
                _buildTab(true, "HOẠT ĐỘNG")
              ],
            ),
            SizedBox(
              height: 8,
            ),
            FutureBuilder<User>(
                future: UserRepository().getCurrentUser(),
                builder: (context, currentUser) {
                  if (currentUser.hasData) {
                    return _buildOnlinePage
                        ? _buildUserOnlines(currentUser)
                        : buildChats(currentUser);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ],
        ),
        drawer: NavDrawer());
  }

  Widget _buildTab(bool isActive, String title) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        setState(() {
          _buildOnlinePage = isActive;
        });
      },
      child: Container(
        // height: size.width * .12,
        width: size.width * .40,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: !(isActive ^ _buildOnlinePage)
                ? Color.fromRGBO(78, 159, 193, 1)
                : Color.fromRGBO(78, 159, 193, 0.4)),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> buildChats(
      AsyncSnapshot<User> currentUser) {
    return StreamBuilder(
        stream: ChatFireBase.getInstance()
            .getConversationStream(currentUser.data!.username!),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            List conversations = snapshot.data!.docs.where((element) {
              return (element['messages'] as List).isNotEmpty;
            }).toList();
            return Expanded(
              child: ListView.builder(
                  itemCount: conversations != null ? conversations.length : 0,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    var conversation = conversations[index];
                    var userNameHim = (conversation['participants'] as List)
                        .firstWhere(
                            (element) => element != currentUser.data!.username);
                    var lastMessage = (conversation['messages'] as List).last;
                    return ItemConversation(
                        conversation,
                        userNameHim.toString(),
                        lastMessage,
                        conversation['status'] == 'Đã xem');
                  }),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                "Hãy bắt đầu cuộc hội thoại ngay để nhận được sự trợ giúp!",
                textAlign: TextAlign.center,
              ),
            ),
          );
        });
  }

  FutureBuilder<List<User>?> _buildUserOnlines(
      AsyncSnapshot<User> currentUser) {
    return FutureBuilder<List<User>?>(
        future: _userOnline,
        builder: (context, userOnlineSnapshot) {
          if (userOnlineSnapshot.hasData) {
            return Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: userOnlineSnapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemUserOnline(userOnlineSnapshot.data![index],
                        currentUser.data!.username!);
                  }),
            );
          } else {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
