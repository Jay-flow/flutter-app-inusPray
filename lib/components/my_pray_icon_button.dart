import 'package:flutter/material.dart';

class MyPrayIconButton extends StatelessWidget {
  MyPrayIconButton({
    @required this.icon,
    this.iconColor = Colors.white,
    this.padding = const EdgeInsets.only(bottom: 5),
  });

  final IconData icon;
  final Color iconColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Icon(
        icon,
        color: iconColor,
      ),
    );
  }
}
