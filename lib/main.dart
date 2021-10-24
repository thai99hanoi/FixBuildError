import 'package:flutter/material.dart';
import 'package:heath_care/ui/chat_conversation.dart';
import 'package:heath_care/ui/home_screen.dart';
import 'package:heath_care/ui/login_screen.dart';
import 'package:heath_care/ui/main_screen.dart';
import 'package:heath_care/ui/new_home.dart';
import 'package:heath_care/ui/splash_screen.dart';
import 'package:provider/provider.dart';

import 'networks/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: Auth(),
        child: Consumer<Auth>(
            builder: (ctx, auth, _) => MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                home: auth.isAuth ? MainScreen() : FutureBuilder(future: auth.tryautoLogin(),
                 builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting ? SplashScreen() : LoginPage()),
               )));

  }
}
