import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/models/mediator_model.dart';
import 'package:flutter_inus_pray/models/user.dart';

class MediatorSearch extends SearchDelegate<User> {
  DateTime currentInputTime = new DateTime.now();

  @override
  String get searchFieldLabel => '이름을 입력해주세요';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length >= 2) {
      startInputTimer();
    }
    currentInputTime = DateTime.now();
    return Text(query);
  }

  void startInputTimer() {
    // 문장을 마친 후 1초 뒤에 Request
    int startNum = 0;
    new Timer.periodic(new Duration(seconds: 1), (time) {
      startNum += 1;
      var inputTime =
          DateTime.now().difference(currentInputTime).inSeconds.toInt();
      if (inputTime == 1) {
        _requestFindMediator(query);
        time.cancel();
      }
      if (startNum == 1 || inputTime > 1) {
        time.cancel();
      }
    });
  }

  _requestFindMediator(String query) async {
    developer.log('Request User');
    List<User> _users = await MediatorModel().findUserName(query);
    _users.forEach((user) => developer.log(user.name.toString()));
  }
}
