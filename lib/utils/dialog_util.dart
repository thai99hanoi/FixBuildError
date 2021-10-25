import 'package:flutter/material.dart';

showErrorDialog(BuildContext context, String title, String message) async {
  await showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(
        title,
        style: TextStyle(color: Colors.blue),
      ),
      content: Text(message),
      actions: <Widget>[
        // ignore: deprecated_member_use
        FlatButton(
          child: Text('Đóng'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    ),
  );
}
