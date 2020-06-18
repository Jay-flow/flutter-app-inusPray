import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/utils/constants.dart';

class ImageButton extends StatelessWidget {
  ImageButton({
    @required this.text,
    @required this.buttonColor,
    @required this.onPressed,
    @required this.iconImage
  });

  final String text;
  final Color buttonColor;
  final Function onPressed;
  final ImageProvider<dynamic> iconImage;

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      color: Color(0xFFFAE003),
      padding: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 30.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            30.0,
          ),
        ),
      ),
      icon: Padding(
        padding: EdgeInsets.only(right: 5.0),
        child: Image(
          image: iconImage,
          width: 40.0,
          height: 40.0,
        ),
      ),
      label: Text(
        text,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
