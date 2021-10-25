import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heath_care/networks/auth.dart';

class ItemNetworkImage extends StatefulWidget {
  String? image;

  ItemNetworkImage({this.image});

  @override
  State<StatefulWidget> createState() {
    return _StateItemNetworkImage();
  }
}

class _StateItemNetworkImage extends State<ItemNetworkImage> {

  Future<String> token = Auth().getToken();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: token,
        builder: (context, snapshot) {
          if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return Center(child: CircularProgressIndicator(),);
          }
          return _buildImage(widget.image, snapshot.data!);
        });
  }

  Widget _buildImage(String? path, String token) {
    if (path == null) {
      return Image.asset('assets/images/image_not_found.png');
    } else {
      return CachedNetworkImage(
        imageUrl: path,
        placeholder:(context, url) =>Text("Đang xử lý hình ảnh!"),
        errorWidget: (context, object, error) {
          return Image.asset('assets/images/image_not_found.png');
        },
      );
    }
  }
}
