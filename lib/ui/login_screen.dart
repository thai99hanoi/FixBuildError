import 'package:flutter/material.dart';
import 'package:heath_care/model/user.dart';
import 'package:heath_care/repository/user_repository.dart';
import 'package:heath_care/ui/otp_screen.dart';
import 'package:heath_care/ui/reset_password.dart';
// import 'package:heath_care/ui/otp_screen.dart';
import 'package:heath_care/utils/app_exceptions.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'package:heath_care/networks/auth.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  bool _showPass = false;
  User user = new User();

  // var url = Uri.http("http://localhost:8080", "/authenticate");
  Future save() async {
    try {
      await Provider.of<Auth>(context, listen: false).login(user);
    } catch (error) {
      var errorMessage = 'Đăng nhập thất bại! \n'
          'Vui lòng kiểm tra lại tài khoản và mật khẩu';
      print(error.toString());
      _showerrorDialog(errorMessage);
    }
  }

  var _userNameErr = "Username is invalid!";
  var _passNameErr = "Password must more than 6 characters";
  var _userInvalid = false;
  var _passInvalid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(30, 100, 30, 0),
        // constraints: BoxConstraints.expand(),
        // color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: SizedBox.fromSize(
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.contain,
                  height: 130,
                  width: 130,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
              child: Text(
                "Hệ Thống Chăm Sóc\n Sức Khoẻ Cho Bệnh Nhân COVID Tại Nhà",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: TextFormField(
                controller: TextEditingController(text: user.username),
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  user.username = val;
                },
                style: TextStyle(fontSize: 18, color: Colors.black),
                decoration: InputDecoration(
                    labelText: "SỐ ĐIỆN THOẠI",
                    errorText: _userInvalid ? _userNameErr : null,
                    labelStyle:
                        TextStyle(color: Color(0xff888888), fontSize: 15)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: <Widget>[
                  TextFormField(
                    controller: TextEditingController(text: user.password),
                    onChanged: (val) {
                      user.password = val;
                    },
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    obscureText: !_showPass,
                    decoration: InputDecoration(
                        labelText: "MẬT KHẨU",
                        errorText: _passInvalid ? _passNameErr : null,
                        labelStyle:
                            TextStyle(color: Color(0xff888888), fontSize: 15)),
                  ),
                  GestureDetector(
                    onTap: onToggleShowPass,
                    child: Text(
                      _showPass ? "ẨN" : "HIỆN MẬT KHẨU",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                // ignore: deprecated_member_use
                child: RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  // onPressed: onSignInClicked,
                  onPressed: save,
                  child: Text(
                    "ĐĂNG NHẬP",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
            Container(
              height: 130,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Text(
                  //   "NEW USER? SIGN UP",
                  //   style: TextStyle(
                  //     fontSize: 15,
                  //     color: Color(0xff888888),
                  //   ),
                  // ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: Color(0xff888888),
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen()),
                      );
                    },
                    child: const Text('Quên Mật Khẩu?'),
                  ),
                  // RaisedButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => OTPScreen()),
                  //     );
                  //   },
                  //   child: Text(
                  //     "FORGOT PASSWORD?",
                  //     style: TextStyle(fontSize: 15, color: Colors.blue),
                  //   ),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }

// void onSignInClicked() {
//   setState(() {
//     if (_userController.text.length < 6 ||
//         !_userController.text.contains("@")) {
//       _userInvalid = true;
//     } else {
//       _userInvalid = false;
//     }
//
//     if (_passController.text.length < 6) {
//       _passInvalid = true;
//     } else {
//       _passInvalid = false;
//     }
//
//     if (!_userInvalid && !_passInvalid) {
//       // Navigator.push(context, MaterialPageRoute(builder: gotoHome));
//     }
//   });
// }
// Widget gotoHome(BuildContext context){
//   return HomePage();
// }

  void _showerrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Thông báo',
          style: TextStyle(color: Colors.blue),
        ),
        content: Text(message,textAlign: TextAlign.center, style: TextStyle(fontSize: 14),),
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton(
            child: Text('Xác nhận'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
