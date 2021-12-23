
import 'package:flutter/material.dart';
import 'package:flutter_ssikit_example/sample/components/toast/toast_example.dart';

/// 主页面
class HomePage extends StatelessWidget {
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
    // List<GroupInfo> list = CardDataConfig.getAllGroup();

    return Container(
        color: Color(0xFFF8F8F8),
        padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.only(top: 10),
                child: TextButton(onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return ToastExample();
                  }));
                }, child: Text('ToastExample')),
                // child: GroupCard(
                //   groupInfo: list[index],
                // ),
              );
            }));
  }
}
