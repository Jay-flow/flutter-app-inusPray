import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  CircleIconButton({
    this.onPressed,
    @required this.padding,
    @required this.child,
    this.fillColor = Colors.white
  });

  final Widget child;
  final Function onPressed;
  final EdgeInsetsGeometry padding;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: child,
      shape: CircleBorder(),
      elevation: 8.0,
      fillColor: fillColor,
      padding: padding,
    );
  }
}
