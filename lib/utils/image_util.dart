import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';

Image imageFromBase64String(BuildContext context, String base64String) {
  return Image.memory(
    base64Decode(base64String),
    width: MediaQuery.of(context).size.width * 0.7,
  );
}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String base64String(Uint8List data) {
  return base64Encode(data);
}
