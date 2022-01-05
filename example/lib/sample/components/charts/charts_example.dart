import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ssikit_example/sample/home/list_item.dart';

class ChartsExamplePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('图标示例'),
      ),
      body: ListView(
        children: <Widget>[
          ListItem(
            title: "BrokenLine 折线图",
            describe: '数据折线图',
            onPressed: () {

            },
          ),
        ],
      ),
    );
  }
}
