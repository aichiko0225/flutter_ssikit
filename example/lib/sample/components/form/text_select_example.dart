
import 'package:flutter/material.dart';
import 'package:flutter_ssikit/flutter_ssikit.dart';

class TextSelectInputExamplePage extends StatelessWidget {
  final String _title;

  TextSelectInputExamplePage(this._title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Text(
                "基本样式：",
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 22,
                ),
              ),
            ),
            SsiTextSelectFormItem(
              title: "证件类型",
              onTip: () {
                SsiToast.show("点击触发onTip回调", context);
              },
              onAddTap: () {
                SsiToast.show("点击触发onAddTap回调", context);
              },
              onRemoveTap: () {
                SsiToast.show("点击触发onRemoveTap回调", context);
              },
              onTap: () {
                SsiToast.show("点击触发回调_onTap", context);
              },
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
              child: Text(
                "全功能样式：",
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 22,
                ),
              ),
            ),
            SsiTextSelectFormItem(
              prefixIconType: SsiPrefixIconType.TYPE_ADD,
              isRequire: true,
              error: "必填项不能为空",
              title: "证件类型",
              subTitle: "这里是副标题",
              tipLabel: "标签",
              onTip: () {
                SsiToast.show("点击触发onTip回调", context);
              },
              onAddTap: () {
                SsiToast.show("点击触发onAddTap回调", context);
              },
              onRemoveTap: () {
                SsiToast.show("点击触发onRemoveTap回调", context);
              },
              onTap: () {
                SsiToast.show("点击触发回调_onTap", context);
              },
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
              child: Text(
                "no error：",
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 22,
                ),
              ),
            ),
            SsiTextSelectFormItem(
              prefixIconType: SsiPrefixIconType.TYPE_ADD,
              isRequire: true,
              title: "证件类型",
              subTitle: "这里是副标题",
              tipLabel: "标签",
              onTip: () {
                SsiToast.show("点击触发onTip回调", context);
              },
              onAddTap: () {
                SsiToast.show("点击触发onAddTap回调", context);
              },
              onRemoveTap: () {
                SsiToast.show("点击触发onRemoveTap回调", context);
              },
              onTap: () {
                SsiToast.show("点击触发回调_onTap", context);
              },
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
              child: Text(
                "autoLayout：",
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 22,
                ),
              ),
            ),
            SsiTextSelectFormItem.autoLayout(
              prefixIconType: SsiPrefixIconType.TYPE_ADD,
              isRequire: true,
              error: "必填项不能为空",
              title: "证件类型",
              subTitle: "这里是副标题",
              tipLabel: "标签",
              onTip: () {
                SsiToast.show("点击触发onTip回调", context);
              },
              onAddTap: () {
                SsiToast.show("点击触发onAddTap回调", context);
              },
              onRemoveTap: () {
                SsiToast.show("点击触发onRemoveTap回调", context);
              },
              onTap: () {
                SsiToast.show("点击触发回调_onTap", context);
              },
            ),
          ],
        ));
  }
}
