import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_inus_pray/components/input_page.dart';

class EditName extends StatefulWidget {
  static const String id = 'edit_name';

  @override
  _EditNameState createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {
  String _name = '';
  User _user;

  @override
  initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _user = Provider.of<User>(context);
  }

  String _validate(String name) {
    if (name.length > 10) {
      return "이름이 너무깁니다. (10자 이하로 입력)";
    }
    if (name.isEmpty) {
      return "이름은 공백으로 둘 수 없습니다.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('프로필 수정'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: InputPage(
              title: '이름 수정',
              hintText: '변경할 이름을 입력해주세요',
              keyboardType: TextInputType.text,
              buttonText: '수정',
              validator: (String value) => _validate(value),
              textValue: _user.name,
              onChange: (name) => _name = name,
              buttonOnPressed: (GlobalKey<FormState> key) {
                if (key.currentState.validate()) {
                  _user.updateUserName(_name.trim());
                }
              }),
        ),
      ),
    );
  }
}
