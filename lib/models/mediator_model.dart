import 'package:flutter_inus_pray/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;

class MediatorModel {
  CollectionReference _userCollection = Firestore.instance.collection('users');

  List<User> _users = [
    User(email: 'army@bagstation.io', name: "아미", church: "우리안에교회"),
    User(email: 'enhyn@gmail.com', name: "조은현", church: "우리안에교회"),
    User(email: 'choi@gmail.com', name: "최진욱", church: "우리안에교회")
  ];

  findUserName(String name) {
    _userCollection
        .orderBy("name")
        .startAt([name])
        .endAt([name + '\uf8ff'])
        .getDocuments()
        .then(
          (snapshot) {
            snapshot.documents.forEach(
              (doc) => developer.log(
                doc["name"].toString(),
              ),
            );
          },
        );
  }
}
