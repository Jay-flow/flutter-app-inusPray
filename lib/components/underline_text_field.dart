import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/utils/constants.dart';

class UnderlineTextField extends StatelessWidget {
  UnderlineTextField(
      {this.keyboardType,
      this.hintText,
      @required this.onChanged,
      this.obscureText = false});

  final TextInputType keyboardType;
  final String hintText;
  final Function onChanged;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.black),
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: kTextFieldDecoration.copyWith(
        hintText: hintText,
      ),
      onChanged: onChanged,
    );
  }
}
