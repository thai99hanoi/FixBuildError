import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:heath_care/model/user.dart';
import 'package:heath_care/repository/user_repository.dart';
import 'package:heath_care/ui/chat_conversation.dart';
import 'package:heath_care/ui/detail_patient_report.dart';
import 'package:heath_care/ui/detail_patient_result.dart';
import 'package:heath_care/ui/doctor_pattient_detail_report.dart';
import 'package:heath_care/utils/api.dart';

class PattientDetail extends StatefulWidget {
  const PattientDetail({Key? key, required this.userName}) : super(key: key);
  final String userName;

  @override
  _PattientDetailState createState() => _PattientDetailState(userName);
}

class _PattientDetailState extends State<PattientDetail> {
  User _user = new User();
  User currentUserName = new User();
  final String? userName;

  _PattientDetailState(this.userName) {
    UserRepository().getUserByUserName(userName!).then((val) => setState(() {
          _user = val!;
        }));
    UserRepository().getCurrentUser().then((val) => setState(() {
          currentUserName = val;
        }));
  }

  @override
  Widget build(BuildContext context) {
    if (_user.lastname == null) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(78, 159, 193, 1),
            title: Text("Chi tiết bệnh nhân"),
          ),
          body: Center(child: CircularProgressIndicator()));
    } else {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(78, 159, 193, 1),
            title: Text("Chi tiết bệnh nhân"),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: _user.avatar == null
                      ? (_user.gender == "Nam"
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage('assets/images/ava_male.png'))
                          : CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage('assets/images/ava_female.png')))
                      : CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              NetworkImage(Api.imageUrl + _user.avatar!)),
                ),
              ),
              Center(
                  child: Text(
                      _user.firstname! +
                          " " +
                          _user.surname! +
                          " " +
                          _user.lastname!,
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500))),
              SizedBox(
                height: 30.0,
              ),
              Center(
                child: SizedBox(
                  width: 130.0,
                  height: 40.0,
                  // ignore: deprecated_member_use
                  child: new RaisedButton(
                    color: Color.fromRGBO(78, 159, 193, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    onPressed: () {
                      CollectionReference chats =
                          FirebaseFirestore.instance.collection('chats');
                      chats
                          .where('participants',
                              arrayContains: currentUserName.username)
                          .get()
                          .then((value) {
                        QueryDocumentSnapshot? chatDocument;
                        List results = value.docs.where((element) {
                          return (element['participants'].toString())
                              .contains(_user.username.toString());
                        }).toList();
                        if (results.isNotEmpty) chatDocument = results.first;

                        if (value.docs.length > 0 && chatDocument != null) {
                          navigatorToConversation(
                              context, chatDocument.reference);
                        } else {
                          chats
                              .add({
                                'messages': [],
                                'participants': [
                                  currentUserName.username,
                                  _user.username
                                ],
                                'updated_time': Timestamp.now(),
                              })
                              .then((value) =>
                                  navigatorToConversation(context, value))
                              .catchError((error) =>
                                  print("Failed to add user: $error"));
                        }
                      });
                    },
                    child: Row(
                      children: [
                        Icon(Icons.message_outlined, color: Colors.white),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Text(
                            'Liên hệ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 40, 0),
                child: Text("THÔNG TIN CHI TIẾT BỆNH NHÂN",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(78, 159, 193, 1))),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(children: [
                  Text("Địa chỉ: ",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                  Text(_user.address.toString(), style: TextStyle(fontSize: 16))
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(children: [
                  Text("Số điện thoại: ",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                  Text(_user.phone.toString(), style: TextStyle(fontSize: 16))
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(children: [
                  Text("Giới tính: ",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                  // _user.gender ?
                  // Text(_user.address.toString(), style: TextStyle(fontSize: 16))
                  // : Text(_user.address.toString(), style: TextStyle(fontSize: 16))
                  Text(_user.gender.toString(), style: TextStyle(fontSize: 16))
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(children: [
                  Text("Email: ",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                  Text(_user.email.toString(), style: TextStyle(fontSize: 16))
                ]),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: SizedBox(
                      width: 130.0,
                      height: 40.0,
                      // ignore: deprecated_member_use
                      child: new RaisedButton(
                        color: Color.fromRGBO(78, 159, 193, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPatientReportScreen(
                                  currentUserId: _user.userId),
                            ),
                          );
                        },
                        child: new Text(
                          'Báo cáo',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: SizedBox(
                      width: 130.0,
                      height: 40.0,
                      // ignore: deprecated_member_use
                      child: new RaisedButton(
                        color: Color.fromRGBO(78, 159, 193, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPatientResultScreen(
                                  currentUserId: _user.userId),
                            ),
                          );
                        },
                        child: new Text(
                          'Xét Nghiệm',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ));
    }
  }

  void navigatorToConversation(
      BuildContext context, DocumentReference chatDocument) {
    Route route = MaterialPageRoute(
        builder: (context) => ConversationChat(chatDocument, _user));
    Navigator.push(context, route);
  }
}
