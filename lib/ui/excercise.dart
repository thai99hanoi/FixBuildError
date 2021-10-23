import 'package:flutter/material.dart';
import 'components/nav_side_bar.dart';

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
          Wrap(children: [
            Row(children: [
              Column(children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.network('https://placeimg.com/640/480/any',
                      width: 150, height: 150, fit: BoxFit.fill),
                )
              ])
            ])
          ])
        ]),
        drawer: const NavDrawer());
  }
}
