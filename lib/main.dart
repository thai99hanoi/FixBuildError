import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:heath_care/ui/login_screen.dart';
import 'package:heath_care/ui/main_screen.dart';
import 'package:heath_care/ui/splash_screen.dart';
import 'package:heath_care/ui/videocall/call_page.dart';
import 'package:provider/provider.dart';

import 'networks/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseFirestore.instance.clearPersistence();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: Auth(),
        child: Consumer<Auth>(builder: (ctx, auth, _) {
          print('rebuild');
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: FutureBuilder<bool>(
                future: auth.isAuth,
                builder: (ctx, snapshot) {
                  if ((snapshot.hasData && snapshot.data == true)) {
                    return MainScreen();
                  } else {
                    return FutureBuilder(
                        future: auth.tryautoLogin(),
                        builder: (ctx, snapshot) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? SplashScreen()
                            : LoginPage());
                  }
                }),
          );
        }));
  }
}