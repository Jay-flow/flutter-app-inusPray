import 'package:flutter/material.dart';

class MediatorSearchingText extends StatelessWidget {
  MediatorSearchingText({this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}
