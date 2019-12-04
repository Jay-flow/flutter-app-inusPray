import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  CircleIconButton({
    @required this.icon,
    this.backgroundColor = Colors.white,
    this.circleSize = 40,
    this.iconSize = 27.0,
    @required this.onPressed,
  });

  final Color backgroundColor;
  final Widget icon;
  final double circleSize;
  final double iconSize;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: circleSize,
      child: IconButton(
        icon: icon,
        iconSize: iconSize,
        color: Colors.black,
        onPressed: onPressed,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
    );
  }
}
