import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  static const String id = "test";

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> with SingleTickerProviderStateMixin {
  Tween<double> tweenOpacity = Tween<double>(begin: 0, end: 1);
  AnimationController controller;
  Animation<double> animation;
  Animation<double> animationOpacity;
  Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.decelerate,
    );
    animationOpacity = tweenOpacity.animate(animation);
    animation.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await Future.delayed(Duration(seconds: 2));
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
//        controller.forward();
      }
    });
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 1.0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  _showOverlay() async {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: -10,
        left: 10,
        right: 10,
        child: SlideTransition(
          position: _offsetAnimation,
          child: FadeTransition(
            opacity: animationOpacity,
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
      ),
    );
    overlayState.insert(overlayEntry);
    controller.forward();
//    overlayEntry.remove();
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
