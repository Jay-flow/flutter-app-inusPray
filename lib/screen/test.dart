import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  static const String id = "test";

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  _showOverlay() async {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 30,
        left: 10,
        right: 10,
        child: Container(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Hello world',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ),
    );
    overlayState.insert(overlayEntry);
    await Future.delayed(Duration(seconds: 2));
    overlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: RaisedButton(
          onPressed: () {
            _showOverlay();
          },
          child: Text("Overlay"),
        ),
      ),
    );
  }
}
