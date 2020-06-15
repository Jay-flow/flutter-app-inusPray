import 'package:cloud_firestore/cloud_firestore.dart';

class Settings {
  CollectionReference settingsCollection =
      Firestore.instance.collection('settings');

  Future<String> getStoreURL() async {
    DocumentSnapshot urls = await settingsCollection.document('urls').get();

    String downloadURL = "안드로이드 다운로드: ${urls.data['androidStore']}\n\n" +
        "아이폰 다운로드: ${urls.data['iosStore']}";
    return downloadURL;
  }
}
