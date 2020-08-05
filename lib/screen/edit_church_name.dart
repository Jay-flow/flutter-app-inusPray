import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:flutter_inus_pray/utils/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_inus_pray/components/input_page.dart';
import 'package:flutter_inus_pray/utils/admob.dart';

class EditChurchName extends StatefulWidget {
  static const String id = 'edit_church_name';

  @override
  _EditChurchNameState createState() => _EditChurchNameState();
}

class _EditChurchNameState extends State<EditChurchName> {
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

  String _validate(String churchName) {
    churchName = churchName.trim();
    if (churchName.isEmpty) {
      return "교회 이름은 공백으로 둘 수 없습니다.";
    }
    if (churchName.length > 15) {
      return "교회 이름이 너무깁니다. (15자 이하로 입력)";
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
              title: '교회 이름 수정',
              hintText: '변경할 교회 이름을 입력해주세요',
              keyboardType: TextInputType.text,
              buttonText: '수정',
              validator: (String value) => _validate(value),
              textValue: _user.church,
              onChange: (name) => _user.church = name,
              buttonOnPressed: (GlobalKey<FormState> key) {
                if (key.currentState.validate()) {
                  _user.updateChurchName(_user.church.trim());
                  Fluttertoast.showToast(
                    msg: "교회 이름이 정상적으로 변경되었습니다",
                    backgroundColor: kToastBackgroundColor,
                  );
                  AdMob().showInterstitialAd();
                  Navigator.pop(context);
                }
              }),
        ),
      ),
    );
  }
}
