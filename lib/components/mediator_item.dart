import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/circle_image.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;

class MediatorItem extends StatelessWidget {
  MediatorItem({this.imagePath, this.title, this.subtitle});

  final String imagePath;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        leading: CircleImage(
          size: 50,
          imagePath: this.imagePath,
        ),
        title: Text(
          this.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(this.subtitle),
        trailing: ActionChip(
          backgroundColor: Colors.pink,
          label: Text(
            '중보하기',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {},
        ),
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Asset.Colors.grey,
          ),
        ),
      ),
    );
  }
}
