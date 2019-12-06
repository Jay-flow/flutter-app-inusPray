import 'package:flutter/material.dart';

class Line extends StatelessWidget {
  Line({this.height, this.width});

  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      height: 1.0,
      width: 100,
      color: Theme.of(context).primaryColor,
    );
  }
}