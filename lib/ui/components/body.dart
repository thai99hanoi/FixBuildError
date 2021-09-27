import 'package:flutter/material.dart';

import 'chat_input_field.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
<<<<<<< HEAD
        Expanded(
          child: ListView.builder(
              itemBuilder: (context, index) => Text("Chat Text")),
        ),
        ChatInputField(
          key: null,
        ),
=======
        Expanded(child: ListView.builder(itemBuilder: (context, index) => Text("Chat Text")),)
        ChatInputField(key: null,),
>>>>>>> main
      ],
    );
  }
}
