import 'package:flutter/material.dart';

class IconButtonWithText extends StatelessWidget {
  IconButtonWithText({
    @required this.text,
    @required this.onPress,
    @required this.icon,
  });

  final String text;
  final Function onPress;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(icon),
          tooltip: text,
          onPressed: onPress,
        ),
        Text(text)
      ],
    );
  }
}
