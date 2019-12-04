import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;

  CircleImage({
    @required this.imagePath,
    this.width = 140,
    this.height = 140,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(imagePath),
        ),
      ),
    );
  }
}
