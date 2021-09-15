import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'package:heath_care/ui/login_screen.dart';
import 'package:heath_care/networks/auth.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Home"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed("/");
            Provider.of<Auth>(context, listen: false).logout();
          },
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Text("Logout"),
          color: Colors.green,
        ),
      ),
    );
  }
}