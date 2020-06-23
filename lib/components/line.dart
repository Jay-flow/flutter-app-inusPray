import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;

class Line extends StatelessWidget {
  Line({this.height, this.width});

  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: Colors.grey,
    );
  }
}