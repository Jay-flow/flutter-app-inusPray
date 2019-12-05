import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final String imagePath;
  final double size;

  CircleImage({
    @required this.imagePath,
    this.size = 140,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: CircleAvatar(
        backgroundImage: NetworkImage(imagePath),
      ),
    );
  }
}
