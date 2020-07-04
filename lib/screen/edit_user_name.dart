import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter_inus_pray/components/input_page.dart';
import 'package:flutter_inus_pray/utils/admob.dart';

class EditUserName extends StatefulWidget {
  static const String id = 'edit_name';

  @override
  _EditUserNameState createState() => _EditUserNameState();
}

class _EditUserNameState extends State<EditUserName> {
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
    name = name.trim();
    if (name.isEmpty) {
      return "이름은 공백으로 둘 수 없습니다.";
    }
    if (name.length > 10) {
      return "이름이 너무깁니다. (10자 이하로 입력)";
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
            onChange: (name) => _user.name = name,
            buttonOnPressed: (GlobalKey<FormState> key) {
              if (key.currentState.validate()) {
                _user.updateUserName(_user.name.trim());
                BotToast.showSimpleNotification(
                  title: "이름이 정상적으로 변경되었습니다",
                  hideCloseButton: true,
                );
                AdMob().showInterstitialAd();
                Navigator.pop(context);
              }
            },
          ),
        ),
      ),
    );
  }
}
