
import 'package:flutter/material.dart';
import 'package:flutter_ssikit_example/sample/components/noticebar/ssi_notice_bar_example.dart';
import '/sample/components/content/text_expanded_example.dart';
import '/sample/components/toast/toast_example.dart';

/// 主页面
class HomePage extends StatelessWidget {

  Map<String, WidgetBuilder> demoList = {
    'ToastExample': (context) {
      return ToastExample();
    },
    'TextExpandedExample': (context) {
      return SsiTextExpandedContentExample();
    },
    'NoticeBarExample': (context) {
      return SsiNoticeBarExample();
    }
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UI组件"),
        leading: null,
        automaticallyImplyLeading: false,
      ),
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {

    return Container(
        color: Color(0xFFF8F8F8),
        padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: demoList.length,
            itemBuilder: (BuildContext context, int index) {
              var text = demoList.keys.toList()[index];
              return Container(
                padding: EdgeInsets.only(top: 10),
                child: TextButton(onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: demoList[text]!));
                }, child: Text(text)),
              );
            }));
  }
}
