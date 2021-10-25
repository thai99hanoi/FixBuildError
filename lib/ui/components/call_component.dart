import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

Widget buildMainRender(
    RTCVideoRenderer render, Size size, bool enableCamera, bool isReady) {
  return Container(
    width: size.width,
    height: size.height,
    child: render.textureId == null
        ? Container()
        : !enableCamera
            ? Center(
                child: Text('Camera Off'),
              )
            : FittedBox(
                fit: BoxFit.cover,
                alignment: Alignment.center,
                child: Center(
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      SizedBox(
                        width: size.width,
                        height: size.height,
                        child: Transform(
                          transform: Matrix4.identity()..rotateY(0.0),
                          alignment: FractionalOffset.center,
                          child: Texture(textureId: render.textureId!),
                        ),
                      ),
                      Visibility(
                          visible: !isReady, child: Text("Đang kết nối...")),
                    ],
                  ),
                ),
              ),
  );
}

Widget buildLocalRender(
    RTCVideoRenderer local,
    String timeCall,
    bool isFrontCamera,
    bool enableCameraLocal,
    Size size,
    List<Widget> children) {
  return Positioned(
    top: 40.0,
    right: 16.0,
    child: Column(
      children: [
        Text(
          timeCall,
          style: TextStyle(
            color: local.textureId == null ? Colors.transparent : Colors.green,
            fontSize: size.width / 26.5,
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Container(
          height: size.width * .5,
          width: size.width * .3,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
            border: Border.all(color: Colors.blueAccent, width: 2.0),
          ),
          child: local.textureId == null
              ? Container()
              : SizedBox(
                  width: size.height,
                  height: size.height,
                  child: !enableCameraLocal
                      ? Center(child: Text("Camera off"))
                      : Transform(
                          transform: Matrix4.identity()
                            ..rotateY(
                              isFrontCamera ? -pi : 0.0,
                            ),
                          alignment: FractionalOffset.center,
                          child: Texture(textureId: local.textureId ?? 1),
                        ),
                ),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            for (var child in children) child,
          ],
        )
      ],
    ),
  );
}

Widget buildVoiceCall(Size size, String timeCall, bool isReady) {
  return Container(
    width: size.width,
    height: size.height,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          timeCall,
          style: TextStyle(
            color: !isReady ? Colors.transparent : Colors.green,
            fontSize: size.width / 26.5,
          ),
        ),
        Text(
          isReady && timeCall.isNotEmpty ? "Đang gọi..." : "Đang kết nối...",
          style: TextStyle(
              fontSize: 20,
              color:
                  isReady && timeCall.isNotEmpty ? Colors.green : Colors.orange,
              fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
