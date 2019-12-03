import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/mocks/user_mock.dart';

class My extends StatefulWidget {
  static const String id = 'my';

  @override
  _MyState createState() => _MyState();
}

// Container(
//   padding:
//       EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
//   child: Text(
//     '비공개',
//     style: TextStyle(
//       color: Colors.white,
//     ),
//   ),
//   decoration: BoxDecoration(
//     color: Colors.red,
//   ),
// ),
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
                  Container(
                    child: ListTile(
                      title: Container(
                        child: Text(
                          '부자되게 해주세요! 행복하게 해주세요! 부자되게 해주세요! 행복하게 해주세요! 부자되게 해주세요! 행복하게 해주세요! 부자되게 해주세요! 행복하게 해주세요! 부자되게 해주세요! 행복하게 해주세요! 부자되게 해주세요! 행복하게 해주세요!',
                        ),
                      ),
                      onTap: () {},
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: Colors.red,
                          width: 5.0
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.purple,
                    height: 100.0,
                  ),
                  Container(
                    color: Colors.green,
                    height: 100.0,
                  ),
                  Container(
                    color: Colors.orange,
                    height: 100.0,
                  ),
                  Container(
                    color: Colors.yellow,
                    height: 100.0,
                  ),
                  Container(
                    color: Colors.pink,
                    height: 100.0,
                  ),
                  Container(
                    color: Colors.red,
                    height: 100.0,
                  ),
                  Container(
                    color: Colors.purple,
                    height: 100.0,
                  ),
                  Container(
                    color: Colors.green,
                    height: 100.0,
                  ),
                  Container(
                    color: Colors.orange,
                    height: 100.0,
                  ),
                  Container(
                    color: Colors.yellow,
                    height: 100.0,
                  ),
                  Container(
                    color: Colors.pink,
                    height: 100.0,
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
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        UserMock.profileImagePath,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 40,
                    padding: EdgeInsets.all(0),
                    child: IconButton(
                      icon: Icon(Icons.create),
                      iconSize: 27.0,
                      color: Colors.black,
                      onPressed: () {},
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
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
