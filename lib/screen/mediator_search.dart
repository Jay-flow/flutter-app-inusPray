import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/mediator_list.dart';
import 'package:flutter_inus_pray/components/mediator_searching_text.dart';
import 'package:flutter_inus_pray/models/mediator.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:flutter_inus_pray/screen/mediator_recommend_list.dart';
import 'package:flutter_inus_pray/utils/settings.dart';
import 'package:provider/provider.dart';

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
      onPressed: () => close(context, null),
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
          return MediatorSearchingText(
            text: "'$query' 검색중...",
          );
        }
        if (query.length >= 2 && snap.connectionState == ConnectionState.done) {
          if (snap.data.length == 0) {
            return MediatorSearchingText(
              text: "'$query'님을 찾을 수 없습니다.",
            );
          }
          return Consumer<User>(
            builder: (
              BuildContext context,
              User myUser,
              Widget widget,
            ) {
              myUser.checkMyMediators(
                mediators: snap.data,
              );
              return MediatorList(
                mediators: snap.data,
                closeMediatorSearch: close,
              );
            },
          );
        }
        return MediatorRecommendList();
      },
      future: Mediator().findUserName(query),
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    Settings().statusBarColor();
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
