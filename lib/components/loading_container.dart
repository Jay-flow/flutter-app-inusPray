import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingContainer extends StatelessWidget {
  LoadingContainer({this.child, this.isLoading});
  
  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        isLoading
        ? Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: SpinKitWave(
                color: Colors.white,
                size: 50.0,
              ),
            ),
          )
        : Container()  
      ],
    );
  }
}
