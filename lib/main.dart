import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:heath_care/repository/user_repository.dart';
import 'package:heath_care/ui/splash_screen.dart';
import 'package:heath_care/utils/navigation_util.dart';
import 'package:oktoast/oktoast.dart';
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
          return OKToast(
            child: MaterialApp(
                navigatorKey: NavigationUtil.navigatorKey,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                home: SplashScreen()),
          );
        }));
  }
}
