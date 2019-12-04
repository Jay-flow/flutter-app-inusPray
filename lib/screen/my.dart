import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/mocks/user_mock.dart';
import 'package:flutter_inus_pray/components/circle_image.dart';
import 'package:flutter_inus_pray/components/edge_decoration_list_tile.dart';
import 'package:flutter_inus_pray/components/circle_icon_button.dart';

class My extends StatefulWidget {
  static const String id = 'my';

  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<My> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Profile(),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  EdgeDecorationListTile(
                    title: Container(
                      child: Text(
                        UserMock.prays[0],
                      ),
                    ),
                    onTap: () {},
                    edgeColor: Colors.red,
                  ),
                  EdgeDecorationListTile(
                    title: Container(
                      child: Text(
                        UserMock.prays[0],
                      ),
                    ),
                    onTap: () {},
                    edgeColor: Colors.purple,
                  ),
                  EdgeDecorationListTile(
                    title: Container(
                      child: Text(
                        UserMock.prays[0],
                      ),
                    ),
                    onTap: () {},
                    edgeColor: Colors.green,
                  ),
                  EdgeDecorationListTile(
                    title: Container(
                      child: Text(
                        UserMock.prays[0],
                      ),
                    ),
                    onTap: () {},
                    edgeColor: Colors.orange,
                  ),
                  EdgeDecorationListTile(
                    title: Container(
                      child: Text(
                        UserMock.prays[0],
                      ),
                    ),
                    onTap: () {},
                    edgeColor: Colors.yellow,
                  ),
                  EdgeDecorationListTile(
                    title: Container(
                      child: Text(
                        UserMock.prays[0],
                      ),
                    ),
                    onTap: () {},
                    edgeColor: Colors.red,
                  ),
                  EdgeDecorationListTile(
                    title: Container(
                      child: Text(
                        UserMock.prays[0],
                      ),
                    ),
                    onTap: () {},
                    edgeColor: Colors.green,
                  ),
                  EdgeDecorationListTile(
                    title: Container(
                      child: Text(
                        UserMock.prays[0],
                      ),
                    ),
                    onTap: () {},
                    edgeColor: Colors.orange,
                  ),
                  EdgeDecorationListTile(
                    title: Container(
                      child: Text(
                        UserMock.prays[0],
                      ),
                    ),
                    onTap: () {},
                    edgeColor: Colors.yellow,
                  ),
                  EdgeDecorationListTile(
                    title: Container(
                      child: Text(
                        UserMock.prays[0],
                      ),
                    ),
                    onTap: () {},
                    edgeColor: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                CircleImage(
                  imagePath: UserMock.profileImagePath,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleIconButton(
                    icon: Icon(
                      Icons.create,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              UserMock.name,
              style: TextStyle(fontSize: 20.0),
            )
          ],
        ),
      ),
    );
  }
}
