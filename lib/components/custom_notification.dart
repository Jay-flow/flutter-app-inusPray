import 'package:flutter/material.dart';

class CustomNotification extends StatefulWidget {
  static const String id = "custom_notification";

  CustomNotification({
    @required this.child,
  });

  final Widget child;

  @override
  _CustomNotificationState createState() => _CustomNotificationState();
}

class _CustomNotificationState extends State<CustomNotification>
    with SingleTickerProviderStateMixin {
  Tween<double> tweenOpacity = Tween<double>(begin: 0, end: 1);
  AnimationController controller;
  Animation<double> animation;
  Animation<double> animationOpacity;
  Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _setVariables();
    animation.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await Future.delayed(Duration(seconds: 2));
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
//        controller.forward();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _initOverlayWidget();
    });
  }

  _setVariables() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.decelerate,
    );
    animationOpacity = tweenOpacity.animate(animation);
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 0.5),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  _initOverlayWidget() async {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 5,
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
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
