import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:heath_care/firebase/call_firebase.dart';
import 'package:heath_care/firebase/chat_firebase.dart';
import 'package:heath_care/model/message.dart';
import 'package:heath_care/model/report.dart';
import 'package:heath_care/model/request_call.dart';
import 'package:heath_care/networks/auth.dart';
import 'package:heath_care/repository/report_dto_repository.dart';
import 'package:heath_care/repository/user_repository.dart';
import 'package:heath_care/ui/report_screen.dart';
import 'package:heath_care/ui/test_screen.dart';
import 'package:heath_care/ui/user_profile_screen.dart';
import 'package:heath_care/ui/videocall/receive_call_page.dart';
import 'package:provider/provider.dart';

import 'chat_list_user.dart';
import 'new_home.dart';
import 'videocall/call_page.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // bool _continue = false;
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
  bool loadDone = false;
  var sub;

  listenerCall() {
    UserRepository().getCurrentUser().then((currentUser) {
      print('user:${currentUser.username}');
      sub = CallFireBase.getInstance()
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
                    "Ng?????i nh???n ??ang c?? cu???c g???i kh??c!", Timestamp.now());
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
    setState(() {
      loadDone = true;
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
    // listenerLogOut();
    listenerCall();
    getLastReport();
    super.initState();
  }

  @override
  void dispose() {
    print('dispose main_screnn');
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
    return loadDone
        ? Scaffold(
            body: <Widget>[
              ReportScreen(lastReport: _report),
              ListUser(),
              homeScreen(),
              TestResultScreen(),
              UserProfileScreen()
            ][pageIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: pageIndex,
              onTap: (value) {
                setState(() {
                  pageIndex = value;
                });
              },
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.analytics_outlined), label: "B??o C??o"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.message), label: "Li??n H???"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.home, size: 45), label: ""),
                BottomNavigationBarItem(
                    icon: Icon(Icons.assignment_returned_outlined),
                    label: "X??t Nghi???m"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "C?? Nh??n")
              ],
            ),
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
