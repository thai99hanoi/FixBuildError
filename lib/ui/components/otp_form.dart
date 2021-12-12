import 'package:flutter/material.dart';
import 'package:heath_care/model/send_otp_request.dart';
import 'package:heath_care/repository/user_repository.dart';
import 'package:heath_care/ui/components/default_button.dart';
import 'package:heath_care/ui/new_password.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({
    Key? key,
  }) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  int? _otp;
  TextEditingController _text1Controller = TextEditingController();
  TextEditingController _text2Controller = TextEditingController();
  TextEditingController _text3Controller = TextEditingController();
  TextEditingController _text4Controller = TextEditingController();
  TextEditingController _text5Controller = TextEditingController();
  TextEditingController _text6Controller = TextEditingController();

  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  FocusNode? pin5FocusNode;
  FocusNode? pin6FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
    pin5FocusNode!.dispose();
    pin6FocusNode!.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          SizedBox(height: 200 * 0.15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 40,
                child: TextFormField(
                  autofocus: true,
                  obscureText: true,
                  controller: _text1Controller,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    nextField(value, pin2FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: 40,
                child: TextFormField(
                  focusNode: pin2FocusNode,
                  obscureText: true,
                  controller: _text2Controller,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) => nextField(value, pin3FocusNode),
                ),
              ),
              SizedBox(
                width: 40,
                child: TextFormField(
                  focusNode: pin3FocusNode,
                  controller: _text3Controller,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) => nextField(value, pin4FocusNode),
                ),
              ),
              SizedBox(
                width: 40,
                child: TextFormField(
                  focusNode: pin4FocusNode,
                  controller: _text4Controller,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) => nextField(value, pin5FocusNode),
                ),
              ),
              SizedBox(
                width: 40,
                child: TextFormField(
                  focusNode: pin5FocusNode,
                  controller: _text5Controller,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    nextField(value, pin6FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: 40,
                child: TextFormField(
                  focusNode: pin6FocusNode,
                  controller: _text6Controller,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    if (value.length == 1) {
                      pin6FocusNode!.unfocus();
                      // Then you need to check is the code is correct or not
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 200 * 0.15),
          DefaultButton(
            text: "Tiếp Tục",
            press: () async {
              _otp = int.parse(_text1Controller.text +
                  _text2Controller.text +
                  _text3Controller.text +
                  _text4Controller.text +
                  _text5Controller.text +
                  _text6Controller.text);
              // var response = UserRepository().sendOtpForgotPassword();
              print(_otp);
              var _response = await UserRepository().verifyOtp(_otp!);
              print(_response);
              if (_response.contains("true")) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewPasswordScreen(_otp!)),
                );
              } else if (_response.contains("RESET_PASSWORD_INVALID_TOKEN")) {
                _showerrorDialog("OTP không hợp lệ");
              } else if (_response.contains("EXPIRE_TOKEN")) {
                _showerrorDialog("OTP đã hết hạn");
              } else {
                _showerrorDialog("Đã xảy ra lỗi");
              }
            },
          )
        ],
      ),
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

final otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 15),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: Colors.black),
  );
}
