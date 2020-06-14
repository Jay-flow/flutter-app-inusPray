import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:provider/provider.dart';

class Mediator extends ChangeNotifier {
  static CollectionReference _userCollection =
      Firestore.instance.collection('users');
  List<User> users;
  Map<String, StreamSubscription<DocumentSnapshot>> mediatorListener = Map();

  Future<void> setMediators(User myUser) async {
    this.users = await findUsers(myUser.mediators);
    notifyListeners();
  }

  setMediatorListener(phoneNumber) async {
    DocumentSnapshot _mediator =
        await _userCollection.document(phoneNumber).get();
    this.mediatorListener[phoneNumber] = _mediator.reference.snapshots().listen(
      (event) {
        Map<String, dynamic> _mediatorData = event.data;
        for (User user in this.users) {
          if (user.phoneNumber == phoneNumber) {
            user.name = _mediatorData['name'];
            user.profileImagePath = _mediatorData['profileImagePath'];
            user.church = _mediatorData['church'];
            user.prays = _mediatorData['prays'];
            user.mediators = _mediatorData['mediators'];
          }
        }
        notifyListeners();
      },
    );
  }

  cancelMediatorListener(phoneNumber) {
    this.mediatorListener[phoneNumber].cancel();
  }

  static Future<List<User>> findUsers(users) async {
    List<User> _users = [];
    await Future.forEach(users, (phoneNumber) async {
      DocumentSnapshot _mediator =
          await _userCollection.document(phoneNumber).get();
      Map<String, dynamic> _mediatorData = _mediator.data;
      if (_mediatorData != null) {
        User _mediatorUser = User(
          phoneNumber: _mediatorData['phoneNumber'],
          name: _mediatorData['name'],
          profileImagePath: _mediatorData['profileImagePath'],
          church: _mediatorData['church'],
          prays: _mediatorData['prays'],
          mediators: _mediatorData['mediators'],
        );
        _users.add(_mediatorUser);
      }
    });
    return _users;
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

  Future<List<User>> recommendUser(myUser) async {
    List<User> _users = [];
    var documents = await _userCollection.limit(10).getDocuments();
    documents.documents.forEach((doc) {
      if (myUser.phoneNumber != doc['phoneNumber'] && _isNotMyMediator(doc, myUser)) {
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
}
