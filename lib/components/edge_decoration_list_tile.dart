import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;
import 'package:flutter_slidable/flutter_slidable.dart';

class EdgeDecorationListTile extends StatefulWidget {
  EdgeDecorationListTile({
    this.title,
    this.edgeWidth = 4.0,
    @required this.edgeColor,
  });

  final Widget title;
  final double edgeWidth;
  final Color edgeColor;

  // _EdgeDecorationListTileState에 있으면 두번 호출 되는 버그 있음
  bool _isSlidableOpen = false;

  @override
  _EdgeDecorationListTileState createState() => _EdgeDecorationListTileState();
}

class _EdgeDecorationListTileState extends State<EdgeDecorationListTile> {

  // 위젯 밖에서 호출 하면 Slidable.of(context)가 null로 되는 버그 있음
  _controlSlidable(BuildContext context) {
    widget._isSlidableOpen
        ? Slidable.of(context).close()
        : Slidable.of(context).open(actionType: SlideActionType.secondary);
    widget._isSlidableOpen = !widget._isSlidableOpen;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7.0),
      child: ListTile(
        title: widget.title,
        onTap: () => _controlSlidable(context),
      ),
      decoration: BoxDecoration(
        border: Border(
          // left: BorderSide(
          //   color: widget.edgeColor,
          //   width: widget.edgeWidth,
          // ),
          top: BorderSide(
            color: Asset.Colors.grey,
          ),
        ),
      ),
    );
  }
}
