import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:heath_care/firebase/call_firebase.dart';
import 'package:heath_care/firebase/chat_firebase.dart';
import 'package:heath_care/model/message.dart';
import 'package:heath_care/model/report.dart';
import 'package:heath_care/model/request_call.dart';
import 'package:heath_care/repository/report_dto_repository.dart';
import 'package:heath_care/repository/user_repository.dart';
import 'package:heath_care/ui/report_screen.dart';
import 'package:heath_care/ui/test_screen.dart';
import 'package:heath_care/ui/user_profile_screen.dart';
import 'package:heath_care/ui/videocall/receive_call_page.dart';

import 'chat_list_user.dart';
import 'new_home.dart';
import 'videocall/call_page.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _continue = false;
  Report? _report;
  int pageIndex = 2;
  // List<Widget> pageList = <Widget>[
  //   ReportScreen(lastReport: _report,),
  //   ListUser(),
  //   homeScreen(),
  //   TestResultScreen(),
  //   UserProfileScreen()
  // ];

  bool isInCall = false;

  listenerCall() {
    UserRepository().getCurrentUser().then((currentUser) {
      CallFireBase.getInstance()
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

  getLastReport() {
    UserRepository().getCurrentUser().then((currentUser) {
      ReportDTORepository()
          .getReport(currentUser.userId!)
          .then((lastReport) => _report = lastReport.last);
    });
  }

  void navigatorPage(Widget page) {
    isInCall = true;
    Route route = MaterialPageRoute(builder: (context) => page);
    Navigator.push(context, route);
  }

  @override
  void initState() {
    listenerCall();
    getLastReport();
    super.initState();
  }

  void onDataChange(val) {
    setState(() {
      _continue = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildUIApp();
  }

  Scaffold buildUIApp() {
    return Scaffold(
      body: <Widget>[
        ReportScreen(lastReport: _report, callback: (val) => onDataChange(val)),
        ListUser(),
        homeScreen(),
        TestResultScreen(),
        UserProfileScreen()
      ][pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (value) {
          if (_continue) {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text(
                  'Lỗi',
                  style: TextStyle(color: Colors.blue),
                ),
                content: Text("Bạn muốn tiếp tục gửi thông báo?"),
                actions: <Widget>[
                  // ignore: deprecated_member_use
                  FlatButton(
                    child: Text('Có'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    child: Text('Không'),
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        _continue = false;
                        pageIndex = value;
                      });
                    },
                  )
                ],
              ),
            );
          } else {
            setState(() {
              pageIndex = value;
            });
          }
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.analytics_outlined), label: "Báo Cáo"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Liên Hệ"),
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 45), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_returned_outlined),
              label: "Xét Nghiệm"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Cá Nhân")
        ],
      ),
    );
  }
}
