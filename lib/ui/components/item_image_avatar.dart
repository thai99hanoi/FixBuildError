import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heath_care/networks/auth.dart';

class ItemAvatarNetworkImage extends StatefulWidget {
  String? image;

  ItemAvatarNetworkImage({this.image});

  @override
  State<StatefulWidget> createState() {
    return _StateItemNetworkImage(image: image);
  }
}

class _StateItemNetworkImage extends State<ItemAvatarNetworkImage> {
  String? image;

  _StateItemNetworkImage({this.image});

  bool _isError = false;

  Future<String?> token = Auth().getToken();

  @override
  Widget build(BuildContext context) {
    ImageProvider imageAvatar;
    if (image != null && !_isError) {
      imageAvatar =
          NetworkImage(image!, headers: {'Authorization': 'Bearer $token'});
    } else {
      imageAvatar = AssetImage('assets/images/img_1.png');
    }
    return FutureBuilder(
        future: token,
        builder: (context, snapshot) {
          return CircleAvatar(
            radius: 24,
            backgroundImage: imageAvatar,
            onBackgroundImageError: (_, __) {
              setState(() {
                _isError = true;
              });
            },
          );
        });
  }
}
