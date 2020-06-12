import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/circle_image.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;

class MediatorItem extends StatelessWidget {
  MediatorItem({
    @required this.imagePath,
    @required this.title,
    @required this.subtitle,
    this.label,
    this.onPress,
    this.chipBackgroundColor,
  });

  final String imagePath;
  final String title;
  final String subtitle;
  final Text label;
  final Function onPress;
  final Color chipBackgroundColor;

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
        trailing: label != null
            ? ActionChip(
                backgroundColor: chipBackgroundColor,
                label: label,
                onPressed: onPress,
              )
            : null,
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
