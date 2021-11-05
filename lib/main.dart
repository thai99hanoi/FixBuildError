import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:heath_care/repository/user_repository.dart';
import 'package:heath_care/ui/home_screen.dart';
import 'package:heath_care/ui/login_screen.dart';
import 'package:heath_care/ui/main_screen.dart';
import 'package:heath_care/ui/splash_screen.dart';
import 'package:provider/provider.dart';

import 'model/user.dart';
import 'networks/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseFirestore.instance.clearPersistence();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<User> currentUser = UserRepository().getCurrentUser();

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
                    if (auth.getCurrentUser() != null) {
                      if (auth.getCurrentUser()?.roleId == 1) {
                        return MainScreen();
                      } else
                        return HomeScreen();
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
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
