import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  CircleButton({
    @required this.child,
    this.backgroundColor = Colors.white,
    @required this.onPressed,
  });

  final Color backgroundColor;
  final Widget child;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      child: RawMaterialButton(
        onPressed: onPressed,
        child: child,
        shape: CircleBorder(),
        fillColor: backgroundColor,
      ),
    );
  }
}
