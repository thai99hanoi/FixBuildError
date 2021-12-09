import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

Image imageFromBase64String(BuildContext context, String base64String) {
  return Image.memory(
    base64Decode(base64String),
    width: MediaQuery.of(context).size.width * 0.7,
  );
}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String base64String(String path, List<int> bytes ) {
  if (path.contains(".jpg")){
    return "data:image/jpg;base64," + base64Encode(bytes);
  } else if (path.contains(".jpeg")) {
    return "data:image/jpeg;base64," + base64Encode(bytes);
  } else if (path.contains(".png")) {
    return "data:image/png;base64," + base64Encode(bytes);
  } else {
    return "Sai ảnh";
  }
}
