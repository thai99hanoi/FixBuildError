import 'package:flutter/material.dart';

import 'chat_input_field.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemBuilder: (context, index) => Text("Chat Text")),
        ),
        ChatInputField(
          key: null,
        ),
      ],
    );
  }
}