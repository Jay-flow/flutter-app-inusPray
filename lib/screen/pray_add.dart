import 'package:flutter/material.dart';

class PrayAdd extends StatefulWidget {
  static const String id = 'pray_add';

  @override
  _PrayAddState createState() => _PrayAddState();
}

class _PrayAddState extends State<PrayAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 기도 추가 하기'),
      ),
    );
  }
}