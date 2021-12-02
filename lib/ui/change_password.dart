import 'package:flutter/material.dart';
import 'package:heath_care/model/password_dto.dart';
import 'package:heath_care/repository/user_repository.dart';
import 'package:heath_care/ui/login_screen.dart';
import 'package:heath_care/utils/http_exception.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  PasswordDTO password = new PasswordDTO();
  TextEditingController _textCurrentPasswordController =
      TextEditingController();
  TextEditingController _textNewPasswordController = TextEditingController();
  TextEditingController _textReEnterNewPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(78, 159, 193, 1),
          title: const Text("ĐỔI MẬT KHẨU"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text("ĐỔI MẬT KHẨU",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 25, 30, 0),
              child: TextFormField(
                controller: TextEditingController(
                    text: _textCurrentPasswordController.text),
                onChanged: (val) {
                  password.oldPassword = val;
                },
                style: const TextStyle(fontSize: 16, color: Colors.black),
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: "Mật Khẩu Cũ (*):",
                    labelStyle: TextStyle(fontSize: 15)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
              child: TextFormField(
                controller: TextEditingController(
                    text: _textNewPasswordController.text),
                obscureText: true,
                onChanged: (val) {
                  password.newPassword = val;
                },
                style: const TextStyle(fontSize: 16, color: Colors.black),
                decoration: const InputDecoration(
                    labelText: "Mật Khẩu Mới (*):",
                    labelStyle: TextStyle(fontSize: 15)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
              child: TextFormField(
                controller: TextEditingController(
                    text: _textReEnterNewPasswordController.text),
                onChanged: (val) {
                  password.reEnterPassword = val;
                },
                obscureText: true,
                style: const TextStyle(fontSize: 16, color: Colors.black),
                decoration: const InputDecoration(
                    labelText: "Nhập Lại Mật Khẩu Mới (*):",
                    labelStyle: TextStyle(fontSize: 15)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Row(
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
                          onPressed: () async {
                            try {
                              await UserRepository().changePassword(password);
                            } on HttpException catch (e) {
                              if (e
                                  .toString()
                                  .contains('CHANGE_PASSWORD_FAIL')) {
                                _showerrorDialog("Xảy ra lỗi");
                              } else if (e
                                  .toString()
                                  .contains('OLD_PASSWORD_DOESNT_MATCH')) {
                                _showerrorDialog(
                                    "Mật khẩu hiện tại không chính xác");
                              } else if (e.toString().contains(
                                  'REPASSWORD_DOESNT_MATCH_NEW_PASS')) {
                                _showerrorDialog(
                                    "Mật khẩu Nhập Lại Không Chính Xác");
                              } else if (e
                                  .toString()
                                  .contains('USER_NOT_FOUND')) {
                                _showerrorDialog("Không tìm thấy người dùng");
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text(
                                      'Thành Công',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    content: Text("Đổi Mật khẩu thành công"),
                                    actions: <Widget>[
                                      // ignore: deprecated_member_use
                                      FlatButton(
                                        child: Text('Okay'),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage()),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                );
                              }
                            }
                          },
                          child: new Text(
                            'Đổi mật khẩu',
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
          ],
        ));
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
