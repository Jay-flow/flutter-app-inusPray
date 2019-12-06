import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/circle_image.dart';
import 'package:flutter_inus_pray/mocks/user_mock.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;

class Mediator extends StatelessWidget {
  static const String id = 'mediator';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('중보자 찾기'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MediatorSearch(),
                );
              },
            )
          ],
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: ListTile(
                leading: CircleImage(
                  size: 50,
                  imagePath: UserMock.profileImagePath,
                ),
                title: Text(
                  UserMock.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(UserMock.church),
                trailing: Icon(
                  Icons.send,
                  color: Asset.Colors.green,
                ),
                onTap: () {},
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Asset.Colors.grey,
                  ),
                ),
              ),
            );
          },
          itemCount: 10,
        ),
      ),
    );
  }
}

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
        onPressed: () {},
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
    return Text(query);
  }
}
