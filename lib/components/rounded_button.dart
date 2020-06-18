import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/utils/constants.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({@required this.text, @required this.buttonColor, @required this.onPressed});

  final String text;
  final Color buttonColor;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: buttonColor,
      borderRadius: BorderRadius.circular(30.0),
      child: MaterialButton(
        onPressed: onPressed,
        height: 50.0,
        minWidth: double.infinity,
        child: Text(
          text,
          style: kRoundButtonTextStyle,
        ),
      ),
    );
  }
}