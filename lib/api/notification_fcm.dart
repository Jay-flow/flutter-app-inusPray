import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class NotificationFCM {
  sendMediator({String userID, String pray}) async {
    String host = "us-central1-flutter-inuspray.cloudfunctions.net";
    String destination = "/api/send-mediator-notifcation";
    Map<String, String> query = {
      "userID": userID,
      "pray": pray,
    };
    Uri uri = Uri.https(host, destination, query);
    http.Response response = await http.post(uri);
    developer.log("Notification Response Code: ${response.statusCode}");
  }
}
