import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_inus_pray/models/user.dart';

class MediatorModel {
  CollectionReference _userCollection = Firestore.instance.collection('users');

  Future<List<User>> findUserName(String name) async {
    List<User> _users = [];
    var documents = await _userCollection
        .orderBy("name")
        .startAt([name]).endAt([name + '\uf8ff']).getDocuments();
    documents.documents.forEach(
      (doc) => _users.add(
        User(
          phoneNumber: doc['phoneNumber'],
          name: doc["name"],
          profileImagePath: doc["profileImagePath"],
          church: doc["church"],
        ),
      ),
    );
    return _users;
  }
}
