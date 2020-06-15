class Notification {
  sendMediator(String userID, String pray) async {
    String host = "https://us-central1-flutter-inuspray.cloudfunctions.net";
    String destination = "/api/send-mediator-notifcation";
    Map<String, String> query = {
      "userID": userID,
      "pray": pray,
    };
    Uri.https(host, destination, query);
  }
}