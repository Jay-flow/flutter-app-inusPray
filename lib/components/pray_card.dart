import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/circle_image.dart';
import 'package:flutter_inus_pray/components/line.dart';
import 'package:flutter_inus_pray/utils/constants.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;

class PrayCard extends StatelessWidget {
  PrayCard({
    @required this.name,
    @required this.imagePath,
    @required this.content,
    this.isWriting = false,
    this.cardWidth,
    this.cardHeight
  });

  final String name;
  final String imagePath;
  final Widget content;
  final bool isWriting;
  final double cardWidth;
  final double cardHeight;

  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: cardWidth,
      height: cardHeight,
      child: Card(
        color: Colors.grey[50],
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          side: BorderSide(
            width: 0.5,
            color: Asset.Colors.grey,
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 23.0),
          child: Column(
            children: <Widget>[
              Text(name, style: kSubTitleTextStyle),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: CircleImage(
                  imagePath: imagePath,
                ),
              ),
              Line(
                width: 100,
                height: 1.0,
              ),
              content,
            ],
          ),
        ),
      ),
    );
  }
}
