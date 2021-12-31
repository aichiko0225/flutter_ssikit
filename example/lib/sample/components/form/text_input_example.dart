import 'package:flutter/material.dart';
import 'package:flutter_ssikit/flutter_ssikit.dart';

class TextInputExamplePage extends StatelessWidget {
  final String _title;

  TextInputExamplePage(this._title);

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

            SsiTextInputFormItem(
              controller: TextEditingController()..text = "300",
              title: "input标题",
              hint: "请输入",
              onTip: () {
                SsiToast.show("点击触发onTip回调", context);
              },
              onAddTap: () {
                SsiToast.show("点击触发onAddTap回调", context);
              },
              onRemoveTap: () {
                SsiToast.show("点击触发onRemoveTap回调", context);
              },
              onChanged: (newValue) {
                SsiToast.show("点击触发回调_${newValue}_onChanged", context);
              },
            ),
            SsiTextInputFormItem(
              controller: TextEditingController()..text = "300",
              title: "input标题",
              unit: "单位",
              hint: "请输入",
              onTip: () {
                SsiToast.show("点击触发onTip回调", context);
              },
              onAddTap: () {
                SsiToast.show("点击触发onAddTap回调", context);
              },
              onRemoveTap: () {
                SsiToast.show("点击触发onRemoveTap回调", context);
              },
              onChanged: (newValue) {
                SsiToast.show("点击触发回调_${newValue}_onChanged", context);
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
            SsiTextInputFormItem(
              controller: TextEditingController()..text = "300",
              prefixIconType: SsiPrefixIconType.TYPE_ADD,
              isRequire: true,
              isEdit: true,
              error: "必填项不能为空(error文本提示)",
              title: "input标题",
              subTitle: "input 副标题 subTitle",
              tipLabel: "tipLabel text",
              unit: "单位",
              hint: "请输入",
              onTip: () {
                SsiToast.show("点击触发onTip回调", context);
              },
              onAddTap: () {
                SsiToast.show("点击触发onAddTap回调", context);
              },
              onRemoveTap: () {
                SsiToast.show("点击触发onRemoveTap回调", context);
              },
              onChanged: (newValue) {
                SsiToast.show("点击触发回调_${newValue}_onChanged", context);
              },
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
              child: Text(
                "（无错误）no error：",
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 22,
                ),
              ),
            ),
            SsiTextInputFormItem(
              controller: TextEditingController()..text = "300",
              prefixIconType: SsiPrefixIconType.TYPE_ADD,
              isRequire: true,
              isEdit: true,
              title: "input标题",
              subTitle: "input 副标题 subTitle",
              tipLabel: "tipLabel text",
              unit: "单位",
              hint: "请输入",
              onTip: () {
                SsiToast.show("点击触发onTip回调", context);
              },
              onAddTap: () {
                SsiToast.show("点击触发onAddTap回调", context);
              },
              onRemoveTap: () {
                SsiToast.show("点击触发onRemoveTap回调", context);
              },
              onChanged: (newValue) {
                SsiToast.show("点击触发回调_${newValue}_onChanged", context);
              },
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
              child: Text(
                "禁用态下可添加删除：",
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 22,
                ),
              ),
            ),
            SsiTextInputFormItem(
              controller: TextEditingController()..text = "300",
              prefixIconType: SsiPrefixIconType.TYPE_ADD,
              isRequire: true,
              isEdit: false,
              isPrefixIconEnabled: true,
              title: "input标题",
              subTitle: "input 副标题 subTitle",
              tipLabel: "tipLabel text",
              unit: "单位",
              hint: "请输入",
              onTip: () {
                SsiToast.show("点击触发onTip回调", context);
              },
              onAddTap: () {
                SsiToast.show("点击触发onAddTap回调", context);
              },
              onRemoveTap: () {
                SsiToast.show("点击触发onRemoveTap回调", context);
              },
              onChanged: (newValue) {
                SsiToast.show("点击触发回调_${newValue}_onChanged", context);
              },
            ),
          ],
        ));
  }
}
