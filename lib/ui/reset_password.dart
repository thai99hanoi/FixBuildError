import 'package:flutter/material.dart';
import 'package:heath_care/model/send_otp_request.dart';
import 'package:heath_care/repository/user_repository.dart';
import 'package:heath_care/ui/login_screen.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:heath_care/ui/otp_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  GlobalKey<FormState> keyForm = new GlobalKey<FormState>();
  SendOtpRequest _request = new SendOtpRequest();
  TextEditingController _textPhoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(78, 159, 193, 1),
          title: const Text("QUÊN MẬT KHẨU"),
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
                    child: Text("KHÔI PHỤC MẬT KHẨU",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 25, 30, 0),
                  child: TextFormField(
                    controller:
                        TextEditingController(text: _textPhoneController.text),
                    onChanged: (val) {
                      _textPhoneController.text = val;
                      _request.phone = val;
                    },
                    validator: MultiValidator([
                      RequiredValidator(
                          errorText: "Vui lòng nhập số điện thoại"),
                      MinLengthValidator(10,
                          errorText: "Vui lòng nhập số điện thoại hợp lệ")
                    ]),
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    decoration: const InputDecoration(
                        labelText: "Số điện thoại(*):",
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
                                      .sendOtpForgotPassword(_request);

                                  print(response.toString());
                                  if (response
                                      .toString()
                                      .contains("Send success!")) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OTPScreen(
                                                _request,
                                              )),
                                    );
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
                                'Tiếp tục',
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
