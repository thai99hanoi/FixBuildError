import 'package:flutter/material.dart';
import 'package:heath_care/model/password_dto.dart';
import 'package:heath_care/repository/user_repository.dart';
import 'package:heath_care/ui/login_screen.dart';
import 'package:heath_care/utils/http_exception.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  GlobalKey<FormState> keyForm = new GlobalKey<FormState>();
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
        body: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: keyForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text("ĐỔI MẬT KHẨU",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 25, 30, 0),
                  child: TextFormField(
                    controller: TextEditingController(
                        text: _textCurrentPasswordController.text),
                    onChanged: (val) {
                      _textCurrentPasswordController.text = val;
                      password.oldPassword = val;
                    },
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Vui lòng nhập mật khẩu cũ"),
                      MinLengthValidator(6,
                          errorText: "Mật khẩu phải nhiều hơn 6 kí tự")
                    ]),
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

                    validator: MultiValidator([
                      RequiredValidator(
                          errorText: "Vui lòng nhập mật khẩu mới"),
                      MinLengthValidator(6,
                          errorText: "Mật khẩu phải nhiều hơn 6 kí tự")
                    ]),
                    onChanged: (val) {
                      _textNewPasswordController.text = val;
                      password.newPassword = val;
                    },
                    // validator:
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
                      _textReEnterNewPasswordController.text = val;
                      password.reEnterPassword = val;
                    },
                    validator: (val) {
                      if (val != _textNewPasswordController.text) {
                        print(_textNewPasswordController.text);
                        print(val);
                        return 'Mật khẩu nhập lại không trùng';
                      }

                      return null;
                    },
                    obscureText: true,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    decoration: const InputDecoration(
                        labelText: "Nhập Lại Mật Khẩu Mới (*):",
                        // errorText: _userInvalid ? _userNameErr : null,
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
                                if (keyForm.currentState == null) {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: Text(
                                        'Lỗi',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      content: Text("Vui Lòng Kiểm Tra Lại"),
                                      actions: <Widget>[
                                        // ignore: deprecated_member_use
                                        FlatButton(
                                          child: Text('Okay'),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                } else if (keyForm.currentState!.validate()) {
                                  var response = await UserRepository()
                                      .changePassword(password);

                                  print(response.toString());
                                  if (response.toString().contains(
                                      'Reset password successfully')) {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: Text(
                                          'Thành Công',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                        content:
                                            Text("Đổi Mật khẩu thành công"),
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
                                  } else if (response
                                      .toString()
                                      .contains('CHANGE_PASSWORD_FAIL')) {
                                    _showerrorDialog("Xảy ra lỗi");
                                  } else if (response
                                      .toString()
                                      .contains('OLD_PASSWORD_DOESNT_MATCH')) {
                                    _showerrorDialog(
                                        "Mật khẩu hiện tại không chính xác");
                                  } else if (response.toString().contains(
                                      'REPASSWORD_DOESNT_MATCH_NEW_PASS')) {
                                    _showerrorDialog(
                                        "Mật khẩu Nhập Lại Không Chính Xác");
                                  } else if (response
                                      .toString()
                                      .contains('USER_NOT_FOUND')) {
                                    _showerrorDialog(
                                        "Không tìm thấy người dùng");
                                  } else {
                                    _showerrorDialog("Xảy ra lỗi");
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
            ),
          ),
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
