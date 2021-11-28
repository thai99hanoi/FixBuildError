import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
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
                style: const TextStyle(fontSize: 16, color: Colors.black),
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
                          onPressed: () {},
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
}
