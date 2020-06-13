import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_inus_pray/models/pray.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:flutter_inus_pray/utils/constants.dart';
import 'package:provider/provider.dart';

class Mediator extends ChangeNotifier {
  CollectionReference _userCollection = Firestore.instance.collection('users');
  List<User> users;

  Future<void> setMediators(User myUser) async {
    this.users = [];
    await Future.forEach(myUser.mediators, (phoneNumber) async {
      DocumentSnapshot _mediator =
          await _userCollection.document(phoneNumber).get();
      Map<String, dynamic> _mediatorData = _mediator.data;
      if (_mediatorData != null) {
        User _mediatorUser = User(
          phoneNumber: _mediatorData['phoneNumber'],
          name: _mediatorData['name'],
          profileImagePath: _mediatorData['profileImagePath'],
          church: _mediatorData['church'],
          prays: _mediatorData['prays'].toList(),
          mediators: _mediatorData['mediators'],
        );
        this.users.add(_mediatorUser);
      }
    });
    notifyListeners();
  }

  Future<List<User>> findUserName(String name) async {
    List<User> _users = [];
    String myPhoneNumber = await User().getLocalUserData();
    var documents = await _userCollection
        .orderBy("name")
        .startAt([name]).endAt([name + '\uf8ff']).getDocuments();
    documents.documents.forEach((doc) {
      if (myPhoneNumber != doc['phoneNumber']) {
        _users.add(
          User(
            phoneNumber: doc['phoneNumber'],
            name: doc["name"],
            profileImagePath: doc["profileImagePath"],
            church: doc["church"],
          ),
        );
      }
    });
    return _users;
  }

  Future<List<User>> recommendUser(context) async {
    List<User> _users = [];
    var documents = await _userCollection.limit(10).getDocuments();
    documents.documents.forEach((doc) {
      final _my = Provider.of<User>(context);
      if (_my.phoneNumber != doc['phoneNumber'] && _isNotMyMediator(doc, _my)) {
        _users.add(
          User(
            phoneNumber: doc['phoneNumber'],
            name: doc["name"],
            profileImagePath: doc["profileImagePath"],
            church: doc["church"],
          ),
        );
      }
    });
    return _users;
  }

  bool _isNotMyMediator(doc, my) {
    bool _isMyMediator = true;
    my.mediators.forEach((phoneNumber) {
      if (doc['phoneNumber'] == phoneNumber) {
        _isMyMediator = false;
      }
    });
    return _isMyMediator;
  }

  Future<List<Pray>> getMediatorPrays(
      List<dynamic> mediatorsPhoneNumbers, String userPhoneNumber) async {
    List<Pray> prays = [];
    mediatorsPhoneNumbers.forEach(
      (mediatorsPhoneNumber) async {
        DocumentSnapshot _mediator =
            await _userCollection.document(mediatorsPhoneNumber).get();

        Map<String, dynamic> _userData = _mediator.data;

        if (_userData != null) {
          String _name = _userData['name'];
          String _profileImagePath = _userData['profileImagePath'];
          List _prays = _userData['prays'].toList();

          _prays.forEach(
            (pray) {
              Pray _pray = Pray(
                name: _name,
                profileImage: _profileImagePath ?? defaultProfileImagePath,
                content: pray,
              );
              prays.add(_pray);
              developer.log(prays.toString(), name: 'MediatorLog');
            },
          );
        } else {
          //TODO:: null 일때 회원정보가 없는걸로 해당 번호의 mediator 데이터 베이스에서 삭제하기
          DocumentSnapshot _user =
              await _userCollection.document(userPhoneNumber).get();
          List _prays = _user.data['prays'].toList();
        }
      },
    );
    developer.log(prays.toString(), name: 'MediatorLog');

    //TODO:: 비동기 문제있음 위에 prays 세팅되기전에 return 되어버림 디버깅 필요.
    return prays;
  }
}