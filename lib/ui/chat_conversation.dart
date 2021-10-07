import 'package:flutter/material.dart';
import 'package:heath_care/model/message.dart';

import 'components/body.dart';

class ConversationChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body:   Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        title: Row(children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/img_1.png"),
          ),
          SizedBox(
            width: 20,
          ),
          Column(children: [
            Text("Username", style: TextStyle(fontSize: 16)),
            Text("Active 3m ago", style: TextStyle(fontSize: 12)),
          ])
        ]),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.send)),
          SizedBox(
            width: 20,
          )
        ]);
  }
}
