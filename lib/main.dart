import 'package:flutter/material.dart';
import 'package:heath_care/networks/auth.dart';
import 'package:heath_care/ui/home_screen.dart';
import 'package:heath_care/ui/splash_screen.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'ui/login_screen.dart';

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
                  home: auth.isAuth
                      ? HomeScreen()
                      : FutureBuilder(
                          future: auth.tryautoLogin(),
                          builder: (ctx, snapshot) =>
                              snapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? SplashScreen()
                                  : LoginPage()),
                )));
  }
}
