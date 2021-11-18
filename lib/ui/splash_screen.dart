import 'package:flutter/material.dart';
import 'package:heath_care/networks/auth.dart';
import 'package:heath_care/ui/home_screen.dart';
import 'package:heath_care/ui/login_screen.dart';
import 'package:heath_care/ui/main_screen.dart';
import 'package:heath_care/utils/navigation_util.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  //check đã login trước đó chưa, chỗ này auth lỗi, check lại logic, nếu isAuth thì mở screen trong
  Future<void> checkLogin() async {
    await Future.delayed(Duration(seconds: 2));

    bool isLoggedIn = await Provider.of<Auth>(context, listen: false).isAuth;
    String role = await Provider.of<Auth>(context, listen: false).role;
    if (isLoggedIn && role != "") {
      if (role == 'admin') {
        NavigationUtil.pushReplacement(
          MaterialPageRoute(
            builder: (context) => MainScreen(),
          ),
        );
      } else if (role == 'Quản lý') {
        NavigationUtil.pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      } else {
        NavigationUtil.pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      }
    } else {
      NavigationUtil.pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }

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
