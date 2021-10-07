import 'package:flutter/material.dart';

class ChatInputField extends StatelessWidget {
  final Function(String) onSendMessage;

  ChatInputField(this.onSendMessage);

  TextEditingController textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 32,
              color: Color(0xFF087949).withOpacity(0.08))
        ]),
        child: SafeArea(
            child: Row(children: [
          Icon(Icons.camera_alt_outlined, color: Colors.blue),
          SizedBox(
            width: 20,
          ),
          Expanded(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20 * 0.75),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(children: [
                    Icon(Icons.sentiment_satisfied_alt_outlined,
                        color: Colors.blue.withOpacity(0.64)),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: TextField(
                          controller: textEditingController,
                          decoration: InputDecoration(
                            hintText: "Type message",
                            border: InputBorder.none,
                          )),
                    ),
                    IconButton(
                        onPressed: () {
                          onSendMessage(textEditingController.text);
                          textEditingController.text = '';
                        },
                        icon: Icon(Icons.send,
                            color: Colors.blue.withOpacity(0.64))),
                  ])))
        ])));
  }
}
