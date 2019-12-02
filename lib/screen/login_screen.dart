import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/underline_text_field.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Asset.Text.appName),
      ),
      body: Container(
        padding: EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '로그인',
              style: Theme.of(context).textTheme.title,
            ),
            Column(
              children: <Widget>[
                UnderlineTextField(
                  keyboardType: TextInputType.emailAddress,
                  hintText: "이메일을 입력해주세요",
                  onChanged: (email) => this.email = email,
                ),
                SizedBox(
                  height: 20,
                ),
                UnderlineTextField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  hintText: "비밀번호를 입력해주세요",
                  onChanged: (password) => this.password = password,
                ),
              ],
            ),
            ButtonTheme(
              minWidth: double.infinity,
              height: 50.0,
              child: RaisedButton(
                color: Theme.of(context).primaryColorDark,
                onPressed: () {
                  
                },
                child: Text(
                  "로그인",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
