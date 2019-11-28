import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/utils/constants.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;
import 'package:flutter_inus_pray/utils/logger.dart';

class InputPage extends StatefulWidget {
  InputPage({
    @required this.title,
    this.hintText,
    this.keyboardType,
    @required this.buttonText,
    @required this.buttonOnPressed,
  });

  final String title;
  final String hintText;
  final String buttonText;
  final TextInputType keyboardType;
  final Function buttonOnPressed;

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.title,
          style: Theme.of(context).textTheme.title,
        ),
        TextField(
          keyboardType: widget.keyboardType,
          decoration: kTextFieldDecoration.copyWith(
            hintText: widget.hintText,
          ),
          onChanged: (inputValue) => value = inputValue,
        ),
        ButtonTheme(
          minWidth: double.infinity,
          height: 50.0,
          child: RaisedButton(
            color: Theme.of(context).primaryColorDark,
            onPressed: widget.buttonOnPressed,
            child: Text(
              widget.buttonText,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
