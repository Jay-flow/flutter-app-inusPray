import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/models/input_type.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:flutter_inus_pray/utils/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

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
  InputType inputType;
  int index;

  _setUpUpdatePrayText() {
    if (inputType == InputType.Update) {
      final args = ModalRoute.of(context).settings.arguments as Map;
      _textController.text = args['pray'];
      index = args['index'];
    }
  }

  @override
  void initState() {
    super.initState();
    inputType = widget.inputType;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _setUpUpdatePrayText();
  }

  bool _validate(String inputText) {
    if (inputText == '') {
      Fluttertoast.showToast(msg: '공백은 입력하실 수 없습니다.');
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
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
                maxLength: 200,
                autofocus: true,
                expands: true,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: null,
                decoration: kTopBorderRadiusInputDecoration.copyWith(
                  hintText: '여기에 기도 내용을 입력해주세요.',
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Consumer<User>(
              builder: (BuildContext context, User user, Widget widget) {
                return ButtonTheme(
                  minWidth: double.infinity,
                  height: 50.0,
                  child: RaisedButton(
                    shape: kBottomBorderRadiusStyle,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      String inputText = _textController.text.trim();
                      inputText =
                          inputText.replaceAll(RegExp(r"\n\n+"), "\n\n");
                      if (_validate(inputText)) {
                        if (inputType == InputType.Update) {
                          user.updateUserPray(index, inputText);
                        } else {
                          user.createUserPray(inputText);
                        }
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      '저장',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
