import 'package:flutter/material.dart';

class EdgeDecorationListTile extends StatelessWidget {
  EdgeDecorationListTile({
    this.title,
    this.onTap,
    this.edgeWidth = 6.0,
    @required this.edgeColor,
  });

  final Widget title;
  final Function onTap;
  final double edgeWidth;
  final Color edgeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7.0),
      child: ListTile(
        title: title,
        onTap: () {},
      ),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: edgeColor,
            width: edgeWidth
          ),
          top: BorderSide(color: Colors.grey[350])
        ),
      ),
    );
  }
}