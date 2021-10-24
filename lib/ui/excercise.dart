import 'package:flutter/material.dart';
import 'components/NavSideBar.dart';

class ExcerciseScreen extends StatelessWidget {
  const ExcerciseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(78, 159, 193, 1),
          title: const Text("BÁO CÁO SỨC KHOẺ HÀNG NGÀY"),
        ),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(8.8),
            child: Wrap(children: [
              InkWell(
                onTap: () {}, // Handle your callback.
                splashColor: Colors.brown.withOpacity(0.5),
                child: Ink(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/ex.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ]),
          )
        ]),
        drawer: NavDrawer());
  }
}
