import 'package:flutter/material.dart';
import 'package:heath_care/ui/components/otp_form.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

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
                  Text("We sent your code to +1 898 860 ***"),
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
        tween: Tween(begin: 30.0, end: 0.0),
        duration: Duration(seconds: 30),
        builder: (_, dynamic value, child) => Text(
          "00:${value.toInt()}",
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
