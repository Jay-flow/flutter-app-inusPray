import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/models/input_type.dart';
import 'package:flutter_inus_pray/utils/constants.dart';

class PrayAdd extends StatefulWidget {
  static const String idCreate = 'pray_add_create';
  static const String idUpdate = 'pray_add_update';

  PrayAdd({@required this.inputType});

  final InputType inputType;

  @override
  _PrayAddState createState() => _PrayAddState();
}

class _PrayAddState extends State<PrayAdd> {
  final _textController = TextEditingController();

  _setUpPrayText(BuildContext context) {
    final prayText = ModalRoute.of(context).settings.arguments;
    _textController.text = prayText;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.inputType == InputType.Update) _setUpPrayText(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          title: Text('내 기도 저장하기'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _textController,
                autofocus: true,
                expands: true,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: kTopBorderRadiusInputDecoration.copyWith(
                  hintText: '여기에 기도 내용을 입력해주세요.',
                ),
              ),
            ),
            ButtonTheme(
              minWidth: double.infinity,
              height: 50.0,
              child: RaisedButton(
                shape: kBottomBorderRadiusStyle,
                color: Theme.of(context).primaryColor,
                onPressed: () {},
                child: Text(
                  '저장',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
