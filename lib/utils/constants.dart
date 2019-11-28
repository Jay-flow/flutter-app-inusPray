import 'package:flutter/material.dart';
import 'asset.dart' as Asset;

const kTitleTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 43.0,
  letterSpacing: 2.5,
  fontWeight: FontWeight.w700,
);

const kRoundButtonTextStyle = TextStyle(
  fontSize: 15.0,
  color: Asset.Colors.blueBlack,
  fontWeight: FontWeight.bold,
);

const kIconBoxStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(
    Radius.circular(12.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
  border: UnderlineInputBorder(),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Asset.Colors.yellow,
      width: 1.5,
    ),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Asset.Colors.yellow,
      width: 2.0,
    ),
  ),
);
