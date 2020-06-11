import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

void setStatusBarColor() async {
  await FlutterStatusbarcolor.setStatusBarColor(Colors.black);
  FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
}
