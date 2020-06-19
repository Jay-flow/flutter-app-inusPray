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

const kSubTitleTextStyle = TextStyle(
  fontSize: 23.0,
);

const kContentsTextStyle = TextStyle(
  fontSize: 17.0,
);

const kTopBorderRadiusInputDecoration = InputDecoration(
  hintText: 'Enter value',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(4.0),
      topRight: Radius.circular(4.0),
    ),
    borderSide: BorderSide(
      color: Colors.black,
      width: 1.0,
    ),
  ),
);

const kBottomBorderRadiusStyle = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(0),
    topRight: Radius.circular(0),
    bottomLeft: Radius.circular(4.0),
    bottomRight: Radius.circular(4.0),
  ),
);

const defaultProfileImagePath =
    'https://firebasestorage.googleapis.com/v0/b/flutter-inuspray.appspot.com/o/profile_images%2Fdefault.png?alt=media&token=693025b1-27e3-4237-80a7-d1f51d7bf821';

BoxDecoration kCardContainerBoxDecoration = BoxDecoration(
  border: Border.all(
    width: 1,
    color: Colors.grey,
  ),
  color: Colors.white,
  borderRadius: BorderRadius.circular(12),
);

const kGradientBackground = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Asset.Colors.hotPink, Asset.Colors.skyBlue],
  ),
);