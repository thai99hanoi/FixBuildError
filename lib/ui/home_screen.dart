import 'package:flutter/material.dart';
import 'package:heath_care/networks/auth.dart';
import 'package:heath_care/repository/user_repository.dart';
import 'package:heath_care/ui/chat_list_user.dart';
import 'package:heath_care/ui/components/NavSideBar.dart';
import 'package:heath_care/ui/login_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future logout() async {
    try {
      await Provider.of<Auth>(context, listen: false)
          .logout()
          .then((value) => UserRepository().updateUserOnline(0));
      Route route = MaterialPageRoute(builder: (context) => LoginPage());
      Navigator.push(context, route);
    } catch (error) {
      var errorMessage = 'Please try again later';
      print(error.toString());
      _showerrorDialog(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            alignment: AlignmentDirectional.centerStart,
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
            child: Row(
              children: [
                SizedBox.fromSize(
                  child: Image.asset(
                    "assets/images/img.png",
                    fit: BoxFit.contain,
                    width: 130.0,
                    height: 125.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: SizedBox.fromSize(
                      child: TextButton(
                          onPressed: null,
                          child: Image.asset(
                            'assets/images/img_2.png',
                            fit: BoxFit.contain,
                            height: 21,
                            width: 21,
                          ))),
                ),
                SizedBox.fromSize(
                  child: Image.asset(
                    "assets/images/img_1.png",
                    fit: BoxFit.contain,
                    height: 53,
                    width: 53,
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: AlignmentDirectional.center,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Text(
              'HƯỚNG DẪN \n SỬ DỤNG PHẦN MỀM',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.teal[500],
                fontSize: 25,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 30, 60, 0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: SizedBox(
                      width: 130.0,
                      height: 125.0,
                      // ignore: deprecated_member_use
                      child: new RaisedButton(
                        color: Color.fromRGBO(78, 159, 193, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        onPressed: () {},
                        child: new Text(
                          'Khai Báo Y Tế',
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
                  Container(
                    child: SizedBox(
                      width: 130.0,
                      height: 125.0,
                      // ignore: deprecated_member_use
                      child: new RaisedButton(
                        color: Color.fromRGBO(78, 159, 193, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        onPressed: () {
                          Route route = MaterialPageRoute(
                              builder: (context) => ListUser());
                          Navigator.push(context, route);
                        },
                        child: new Text(
                          'Liên Hệ',
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 20, 60, 0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: SizedBox(
                      width: 130.0,
                      height: 125.0,
                      // ignore: deprecated_member_use
                      child: new RaisedButton(
                        color: Color.fromRGBO(78, 159, 193, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        onPressed: () {},
                        child: new Text(
                          'Khai Báo y Tế',
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
                  Container(
                    child: SizedBox(
                      width: 130.0,
                      height: 125.0,
                      // ignore: deprecated_member_use
                      child: new RaisedButton(
                        color: Color.fromRGBO(78, 159, 193, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        onPressed: () {},
                        child: new Text(
                          'Báo Cáo Tình Trạng Sức Khoẻ',
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 20, 60, 0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: SizedBox(
                      width: 130.0,
                      height: 125.0,
                      // ignore: deprecated_member_use
                      child: new RaisedButton(
                        color: Color.fromRGBO(78, 159, 193, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        onPressed: () {},
                        child: new Text(
                          'Khai Báo y Tế',
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
                  Container(
                    child: SizedBox(
                      width: 130.0,
                      height: 125.0,
                      // ignore: deprecated_member_use
                      child: new RaisedButton(
                        color: Color.fromRGBO(78, 159, 193, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        onPressed: () {
                          logout();
                        },
                        child: new Text(
                          'Đăng Xuất',
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
            ),
          )
        ],
      ),
      drawer: NavDrawer(),
    );
  }

  void _showerrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'An Error Occurs',
          style: TextStyle(color: Colors.blue),
        ),
        content: Text(message),
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
