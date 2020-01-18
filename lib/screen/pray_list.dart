import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/circle_image.dart';
import 'package:flutter_inus_pray/models/pray.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PrayList extends StatefulWidget {
  static const String id = 'pray_list';

  @override
  _PrayListState createState() => _PrayListState();
}

class _PrayListState extends State<PrayList> {
  List<Pray> _prays = [];
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final _user = Provider.of<User>(context);
    _user.prays.forEach((value) {
      Pray _pray = Pray(
          name: _user.name, profileImage: _user.profileImage, content: value);
      return _prays.add(_pray);
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        child: SpinKitFadingCircle(
          color: Colors.black,
        ),
      );
    } else if (_prays.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            FontAwesomeIcons.pray,
            size: 100,
          ),
          SizedBox(
            height: 40,
          ),
          Text('등록된 기도가 없습니다.\n내 기도 또는 같이 기도할 중보자를 추가해주세요.'),
        ],
      );
    } else {
      return ListView.builder(
        itemCount: _prays.length,
        itemBuilder: (_, index) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: ListTile(
              leading: CircleImage(
                size: 50,
                imagePath: _prays[index].profileImage,
              ),
              title: Text(
                _prays[index].name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(_prays[index].content),
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
      );
    }
  }
}
