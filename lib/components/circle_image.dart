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
    return ClipOval(
      child: FadeInImage.assetNetwork(
        width: size,
        height: size,
        placeholder: 'res/images/loding_spinner.gif',
        image: imagePath,
      ),
    );
  }
}
