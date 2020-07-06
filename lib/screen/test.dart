import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  static const String id = "test";

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> with SingleTickerProviderStateMixin {
  _showOverlay() async {
    Tween<double> tweenOpacity = Tween<double>(begin: 0, end: 1);
    AnimationController controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    Animation<double> animation = CurvedAnimation(
      parent: controller,
      curve: Curves.decelerate,
    );
    Animation<double> animationOpacity = tweenOpacity.animate(animation);

    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => FadeTransition(
        opacity: animationOpacity,
        child: Positioned(
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
