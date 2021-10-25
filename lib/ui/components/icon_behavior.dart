import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconButtonBehavior extends StatelessWidget {
  Widget icon;
  double height;
  double width;
  Function onTap;
  Color? backgroundColor;

  IconButtonBehavior(this.icon, this.height, this.width, this.onTap,
      {this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor ?? Colors.grey.withOpacity(0.6),
        ),
        alignment: Alignment.center,
        child: icon,
      ),
    );
  }

}
