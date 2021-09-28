import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox.fromSize(
          child: Image.asset(
            "assets/images/logo.png",
            fit: BoxFit.contain,
            height: 130,
            width: 130,
          ),
        ),
      ),
    );
  }
}