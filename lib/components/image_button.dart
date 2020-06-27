import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;

class ImageButton extends StatelessWidget {
  ImageButton(
      {@required this.text,
      @required this.buttonColor,
      @required this.onPressed,
      @required this.iconImage});

  final String text;
  final Color buttonColor;
  final Function onPressed;
  final ImageProvider<dynamic> iconImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FlatButton.icon(
        color: Asset.Colors.white,
        padding: EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 30.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              30.0,
            ),
          ),
        ),
        icon: Image(
          image: iconImage,
          width: 23.0,
          height: 23.0,
        ),
        label: Expanded(
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
