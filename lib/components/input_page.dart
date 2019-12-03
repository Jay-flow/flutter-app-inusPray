import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/underline_text_field.dart';

class InputPage extends StatefulWidget {
  InputPage({
    @required this.title,
    this.hintText,
    this.keyboardType,
    @required this.buttonText,
    @required this.buttonOnPressed,
    this.obscureText = false,
    this.textValue
  });

  final String title;
  final String hintText;
  final String buttonText;
  final TextInputType keyboardType;
  final Function buttonOnPressed;
  final bool obscureText;
  final String textValue;

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
        UnderlineTextField(
          keyboardType: widget.keyboardType,
          hintText: widget.hintText,
          obscureText: widget.obscureText,
          onChanged: (inputValue) => value = inputValue,
          textValue: widget.textValue,
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
