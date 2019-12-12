import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inus_pray/components/underline_text_field.dart';
import 'package:flutter_inus_pray/utils/constants.dart';

class InputPage extends StatefulWidget {
  InputPage({
    this.key,
    @required this.title,
    this.hintText,
    this.keyboardType,
    @required this.buttonText,
    @required this.buttonOnPressed,
    this.obscureText = false,
    this.textValue,
    this.onChange,
    this.inputFormatters,
    this.validator,
  });

  final Key key;
  final String title;
  final String hintText;
  final String buttonText;
  final TextInputType keyboardType;
  final Function buttonOnPressed;
  final bool obscureText;
  final String textValue;
  final Function onChange;
  final List<TextInputFormatter> inputFormatters;
  final Function validator;
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final _formKey = GlobalKey<FormState>();
  String value;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.title,
            style: kTitleTextStyle.copyWith(
              color: Theme.of(context).primaryColorDark,
              fontWeight: FontWeight.normal,
            ),
          ),
          Container(
            height: 100,
            child: UnderlineTextField(
              validator: widget.validator,
              keyboardType: widget.keyboardType,
              hintText: widget.hintText,
              obscureText: widget.obscureText,
              onChanged: widget.onChange,
              textValue: widget.textValue,
              inputFormatters: widget.inputFormatters,
            ),
          ),
          ButtonTheme(
            minWidth: double.infinity,
            splashColor: Theme.of(context).accentColor,
            height: 50.0,
            child: RaisedButton(
              color: Theme.of(context).primaryColorDark,
              onPressed: () => widget.buttonOnPressed(_formKey),
              child: Text(
                widget.buttonText,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
