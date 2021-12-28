import 'package:flutter/material.dart';
import 'package:flutter_ssikit/flutter_ssikit.dart';

/// 列表项
class ListItem extends StatefulWidget {
  /// 点击事件
  final VoidCallback? onPressed;

  /// 标题
  final String title;
  final double? titleFontSize;
  final Color? titleColor;
  final String? imgPath;

  /// 描述
  final String describe;
  final Color? describeColor;

  /// 右侧控件
  final Widget? rightWidget;
  final bool isSupportTheme;
  final bool isShowLine;

  /// 构造函数
  ListItem({
    Key? key,
    this.onPressed,
    this.title = "",
    this.titleFontSize,
    this.titleColor,
    this.describe = "",
    this.describeColor: Colors.grey,
    this.rightWidget,
    this.imgPath,
    this.isSupportTheme = false,
    this.isShowLine = true,
  }) : super(key: key);

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: widget.onPressed,
      padding: EdgeInsets.all(0.0),
      shape: Border.all(
        color: Colors.transparent,
        width: 0.0,
        style: BorderStyle.none,
      ),
      child: Container(
          color: Colors.white,
          width: double.infinity,
          padding: EdgeInsets.only(left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.isShowLine
                  ? SsiLine(
                      color: Color(0xFFEEEEEE),
                      height: 1,
                    )
                  : Container(),
              SsiLine(
                height: 14,
                color: Colors.transparent,
              ),
              Wrap(children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      color: widget.titleColor ?? Color(0xFF222222),
                      fontSize: widget.titleFontSize ?? 14),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4),
                ),
              ]),
              Padding(padding: EdgeInsets.all(2)),
              Text(
                widget.describe,
                style: TextStyle(color: widget.describeColor ?? Color(0xFF999999), fontSize: 12),
              ),
              SsiLine(
                height: 14,
                color: Colors.transparent,
              )
            ],
          )),
    );
  }
}
