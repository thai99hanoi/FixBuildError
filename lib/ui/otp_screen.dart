import 'package:flutter/material.dart';
import 'package:heath_care/model/send_otp_request.dart';
import 'package:heath_care/ui/components/otp_form.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen(this.phoneNumber);
  final SendOtpRequest phoneNumber;
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Trang Chủ"),
          backgroundColor: Color.fromRGBO(78, 159, 193, 1),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 200 * 0.05),
                  Text(
                    "OTP Verification",
                    style: headingStyle,
                  ),
                  Text("We sent your code to " +
                      widget.phoneNumber.phone.toString() +
                      " ***"),
                  buildTimer(),
                  OtpForm(),
                  SizedBox(height: 200 * 0.1),
                  GestureDetector(
                    onTap: () {
                      // OTP code resend
                    },
                    child: Text(
                      "Resend OTP Code",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

Row buildTimer() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("This code will expired in "),
      TweenAnimationBuilder(
        tween: Tween(begin: 120.0, end: 0.0),
        duration: Duration(seconds: 120),
        builder: (_, dynamic value, child) => Text(
          value.toInt().toString() + "s",
          style: TextStyle(color: Colors.black),
        ),
      ),
    ],
  );
}

final headingStyle = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);
