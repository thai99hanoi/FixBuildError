import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:heath_care/model/reset_password.dart';
import 'package:heath_care/repository/user_repository.dart';
import 'package:heath_care/ui/login_screen.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen(this.token);
  final int token;
  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  GlobalKey<FormState> keyForm = new GlobalKey<FormState>();
  ResetPassword password = new ResetPassword();
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
            autovalidateMode: AutovalidateMode.always,
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
                      // password.password = val;
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
                      password.password = val;
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
                                      .resetPassword(
                                          password, widget.token.toString());

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
                                        content: Text(
                                            "Khôi phục Mật khẩu thành công"),
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
                                  } else if (response.toString().contains(
                                      'RESET_PASSWORD_INVALID_TOKEN')) {
                                    _showerrorDialog(
                                        "Khôi phục mật khẩu không thành công");
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
