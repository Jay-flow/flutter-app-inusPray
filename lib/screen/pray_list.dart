import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/mediator_item.dart';
import 'package:flutter_inus_pray/models/mediator.dart';
import 'package:flutter_inus_pray/models/pray.dart';
import 'package:flutter_inus_pray/models/user.dart';
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
    _requestPrayList();
  }

  void _requestPrayList() async {
    final _user = Provider.of<User>(context);
    await _mediatorPrayList(_user);
    await _myPrayList(_user);
    setState(() {
      _isLoading = false;
    });
  }

  _mediatorPrayList(User user) async {
    List<Pray> _mediatorPrays = await Mediator().getMediatorPrays(
      user.mediators,
      user.phoneNumber,
    );
    _mediatorPrays.forEach((pray) => _prays.add(pray));
  }

  _myPrayList(User user) {
    user.prays.forEach((value) {
      Pray _pray = Pray(
          name: user.name, profileImage: user.profileImage, content: value);
      return _prays.add(_pray);
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
          return MediatorItem(
            imagePath: _prays[index].profileImage,
            title: _prays[index].name,
            subtitle: _prays[index].content,
          );
        },
      );
    }
  }
}
