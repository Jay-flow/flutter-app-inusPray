import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  CircleIconButton({
    this.onPressed,
    this.padding,
    @required this.child,
  });

  final Widget child;
  final Function onPressed;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: child,
      shape: CircleBorder(),
      elevation: 2.0,
      fillColor: Colors.white,
      padding: padding,
    );
  }
}
