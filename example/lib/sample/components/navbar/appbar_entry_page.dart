
import 'package:flutter/material.dart';
import 'package:flutter_ssikit/flutter_ssikit.dart';
import 'package:flutter_ssikit_example/sample/home/list_item.dart';

import 'nav_bar_example_page.dart';

class AppbarEntryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SsiAppBar(
          title: 'NavBar示例',
        ),
        body: ListView(
          children: <Widget>[
            ListItem(
              title: "NavBar示例",
              describe: 'Navbar/黑/2个文字模块切换+左右2icon',
              isShowLine: false,
              onPressed: () {
                _openNavBarPage(context, 0);
              },
            ),
            ListItem(
              title: "NavBar示例",
              describe: 'Navbar/黑/文字标题+左侧2icon+右侧文字+浮窗',
              onPressed: () {
                _openNavBarPage(context, 4);
              },
            ),
            ListItem(
              title: "NavBar示例",
              describe: 'Navbar/黑/文字标题+下拉选择',
              onPressed: () {
                _openNavBarPage(context, 5);
              },
            ),
            ListItem(
              title: "Navbar示例",
              describe: 'Navbar/白/文字标题+左侧icon',
              onPressed: () {
                _openNavBarPage(context, 8);
              },
            ),
            ListItem(
              title: "Navbar示例",
              describe: 'Navbar/白/文字标题+文字标签+左侧icon',
              onPressed: () {
                _openNavBarPage(context, 9);
              },
            ),
            ListItem(
              title: "Navbar示例",
              describe: 'Navbar/白/文字标题+左侧2icon+右侧文字+浮窗',
              onPressed: () {
                _openNavBarPage(context, 10);
              },
            ),
            ListItem(
              title: "Navbar示例",
              describe: 'Navbar/黑',
              onPressed: () {
                _openNavBarPage(context, 11);
              },
            ),
            ListItem(
              title: "Navbar示例",
              describe: 'Navbar/白',
              onPressed: () {
                _openNavBarPage(context, 12);
              },
            ),
            ListItem(
              title: "Navbar示例",
              describe: '多文本切换',
              onPressed: () {
                _openNavBarPage(context, 14);
              },
            ),

            const ListTile(title: Text('渐变色示例')),

            ListItem(
              title: "GradientNavbar示例",
              describe: '默认样式',
              onPressed: () {
                _openNavBarPage(context, 30);
              },
            ),
            ListItem(
              title: "GradientNavbar示例",
              describe: '没有leading',
              onPressed: () {
                _openNavBarPage(context, 32);
              },
            ),
            ListItem(
              title: "GradientNavbar示例",
              describe: '标题靠左侧',
              onPressed: () {
                _openNavBarPage(context, 31);
              },
            ),
            
          ],
        ));
  }

  _openNavBarPage(BuildContext context, int index) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return NavBarPage(index);
    }));
  }
}
