import 'package:cloud_firestore/cloud_firestore.dart';

class Settings {
  CollectionReference settingsCollection = Firestore.instance.collection('settings');
  
  Future<Map<String, dynamic>> getStoreURL() async {
    DocumentSnapshot urls = await settingsCollection.document('urls').get();
    return urls.data;
  }
}