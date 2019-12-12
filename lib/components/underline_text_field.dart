import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inus_pray/utils/constants.dart';

class UnderlineTextField extends StatefulWidget {
  UnderlineTextField({
    this.keyboardType,
    this.hintText,
    @required this.onChanged,
    this.textValue,
    this.obscureText = false,
    this.textAlign = TextAlign.start,
    this.inputFormatters,
    this.validator,
  });

  final TextInputType keyboardType;
  final String hintText;
  final Function onChanged;
  final bool obscureText;
  final String textValue;
  final TextAlign textAlign;
  final List<TextInputFormatter> inputFormatters;
  final Function validator;

  @override
  _UnderlineTextFieldState createState() => _UnderlineTextFieldState();
}

class _UnderlineTextFieldState extends State<UnderlineTextField> {
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.text = widget.textValue;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: _textController,
      style: TextStyle(color: Colors.black),
      obscureText: widget.obscureText,
      textAlign: widget.textAlign,
      keyboardType: widget.keyboardType,
      decoration: kTextFieldDecoration.copyWith(
        hintText: widget.hintText,
      ),
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
    );
  }
}
