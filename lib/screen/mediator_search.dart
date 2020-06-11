import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/mediator_item.dart';
import 'package:flutter_inus_pray/models/mediator_model.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:flutter_inus_pray/utils/tools.dart' as Tools;

class MediatorSearch extends SearchDelegate<User> {
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
    return FutureBuilder(
      builder: (context, snap) {
        if (query.length >= 2 &&
            snap.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "검색중...",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          );
        }
        if (query.length >= 2 && snap.connectionState == ConnectionState.done) {
          if (snap.data.length == 0) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "'$query'님을 찾을 수 없습니다.",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: snap.data.length,
            itemBuilder: (_, index) {
              return MediatorItem(
                imagePath: snap.data[index].profileImage,
                title: snap.data[index].name,
                subtitle: snap.data[index].church,
              );
            },
          );
        }
        return Container();
      },
      future: MediatorModel().findUserName(query),
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    Tools.setStatusBarColor();
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: Colors.white,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
      primaryColorBrightness: Brightness.light,
      primaryTextTheme: theme.textTheme,
    );
  }
}
