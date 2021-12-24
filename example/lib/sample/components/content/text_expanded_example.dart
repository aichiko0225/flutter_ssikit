import 'package:flutter/material.dart';
import 'package:flutter_ssikit/flutter_ssikit.dart';

class SsiTextExpandedContentExample extends StatefulWidget {
  @override
  _SsiTextExpandedContentExampleState createState() =>
      _SsiTextExpandedContentExampleState();
}

class _SsiTextExpandedContentExampleState
    extends State<SsiTextExpandedContentExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('展开收起文本'),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.only(left: 12, right: 12, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '规则',
              style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '正常案例',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 28,
              ),
            ),
            Text(
              'UI平台一致性 \n由于Flutter使用自己的引擎进行UI渲染，而不是用原生控件渲染，导致控件显示效果和原生不是完全一样，虽然肉眼看起来基本一样，'
              '但还是有一些细微的差别，尤其当Android和iOS系统升级导致原生控件效果发生变化时，Flutter开发的App并不会进行相应的变化，如果您的App需要原生控件保持完全一致，Flutter可能并不适合您。',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 14,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '收缩文本案例',
                      style: TextStyle(
                        color: Color(0xFF222222),
                        fontSize: 28,
                      ),
                    ),
                    SsiExpandableText(
                      text:
                          '由于Flutter使用自己的引擎进行UI渲染，而不是用原生控件渲染，导致控件显示效果和原生不是完全一样，虽然肉眼看起来基本一样，'
                          '但还是有一些细微的差别，尤其当Android和iOS系统升级导致原生控件效果发生变化时，Flutter开发的App并不会进行相应的变化，如果您的App需要原生控件保持完全一致，Flutter可能并不适合您。',
                      onExpanded: (value) {
                        SsiToast.show("当前的状态是$value", context);
                      },
                      maxLines: 2,
                    ),
                  ],
                ))
          ],
        ),
      )),
    );
  }
}
