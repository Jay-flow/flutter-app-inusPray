import 'package:http/http.dart' as http;

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
  }
}
