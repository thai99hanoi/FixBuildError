import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:heath_care/firebase/call_firebase.dart';
import 'package:heath_care/firebase/chat_firebase.dart';
import 'package:heath_care/model/message.dart';
import 'package:heath_care/model/request_call.dart';
import 'package:heath_care/networks/auth.dart';
import 'package:heath_care/repository/user_repository.dart';
import 'package:heath_care/ui/chat_doctor.dart';
import 'package:heath_care/ui/doctor_all_contact.dart';
import 'package:heath_care/ui/home_doctor.dart';
import 'package:heath_care/ui/report_screen.dart';
import 'package:heath_care/ui/test_screen.dart';
import 'package:heath_care/ui/user_profile_screen.dart';
import 'package:heath_care/ui/videocall/receive_call_page.dart';
import 'package:provider/provider.dart';

import 'chat_list_user.dart';
import 'new_home.dart';
import 'videocall/call_page.dart';

class MainScreenDoctor extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreenDoctor> {
  int pageIndex = 0;
  List<Widget> pageList = <Widget>[
    homeScreenDoctor(),
    ListAllPattients(),
    ChatDoctor(),
    UserProfileScreen()
  ];

  bool isInCall = false;
  var sub;
  listenerCall() {
    UserRepository().getCurrentUser().then((currentUser) {
     sub =  CallFireBase.getInstance()
          .getRequestsStream(currentUser.username.toString())
          .listen((event) {
        final datas = event.docs;
        if (isInCall) {
          if (event.docChanges.isNotEmpty) {
            event.docChanges.forEach((element) {
              final data = element.doc.data();
              RequestCall request = RequestCall.fromJson(data!);
              if (element.type == DocumentChangeType.added &&
                  request.completed == false &&
                  request.inComingCall == true) {
                Message message = Message(currentUser.username!,
                    "Người nhận đang có cuộc gọi khác!", Timestamp.now());
                ChatFireBase.getInstance()
                    .sendMessageWithId(message, data['chat_id']);
                element.doc.reference.update({'completed': true});
              }
            });
          }
        } else if (datas.isNotEmpty && !isInCall) {
          RequestCall firstRequest = RequestCall.fromJson(datas.first.data());
          if (firstRequest.from == currentUser.username) {
            navigatorPage(CallPage(firstRequest.isVoiceCall, true,
                datas.first.reference, currentUser.username, () {
              isInCall = false;
            }));
          } else if (firstRequest.inComingCall == false) {
            navigatorPage(CallPage(firstRequest.isVoiceCall, false,
                datas.first.reference, currentUser.username, () {
              isInCall = false;
            }));
          } else if (firstRequest.roomId?.isNotEmpty == true) {
            navigatorPage(ReceiveCallPage(
              datas.first.reference,
              () {
                isInCall = false;
              },
              fullNameFrom: firstRequest.fullNameFrom,
              avatarFrom: firstRequest.avatarFrom,
            ));
          }
        }
      });
    });
  }

  void navigatorPage(Widget page) {
    isInCall = true;
    Route route = MaterialPageRoute(builder: (context) => page);
    Navigator.push(context, route);
  }

  listenerLogOut() {
    var isLogout = Provider.of<Auth>(context, listen: false).isLogout;
    if (isLogout) {
      print('logout');
      sub?.cancel();
    }
  }

  @override
  void initState() {
    isInCall = false;
    listenerCall();
    super.initState();
  }

  @override
  void dispose() {
    print('dispose main doctor');
    super.dispose();
    isInCall = false;
    sub?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    listenerLogOut();
    return buildUIApp();
  }

  Scaffold buildUIApp() {
    return Scaffold(
      body: pageList[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Trang Chủ"),
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_phone_outlined), label: "Liên Hệ"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Tin Nhắn"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Cá Nhân")
        ],
      ),
    );
  }
}
