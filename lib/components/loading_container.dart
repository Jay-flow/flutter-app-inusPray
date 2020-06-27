import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;

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
                color: Colors.black.withOpacity(0.3),
                child: Center(
                  child: SpinKitFadingCircle(
                    color: Asset.Colors.white,
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
