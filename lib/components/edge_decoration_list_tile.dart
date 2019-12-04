import 'package:flutter/material.dart';

class EdgeDecorationListTile extends StatelessWidget {
  EdgeDecorationListTile({
    this.title,
    this.onTap,
    this.edgeWidth = 5.0,
    @required this.edgeColor,
  });

  final Widget title;
  final Function onTap;
  final double edgeWidth;
  final Color edgeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        ),
      ),
    );
  }
}