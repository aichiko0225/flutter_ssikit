import 'package:flutter/material.dart';
import 'package:flutter_ssikit/flutter_ssikit.dart';

class ToastExample extends StatefulWidget {
  @override
  _ToastExampleState createState() => _ToastExampleState();
}

class _ToastExampleState extends State<ToastExample> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SsiToast示例'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 50, bottom: 50),
              child: Center(
                child: RaisedButton(
                  onPressed: () {
                    SsiToast.show("普通长Toast", context, duration: SsiToast.LENGTH_LONG, gravity: 1);
                  },
                  child: Text("普通长Toast"),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50, bottom: 50),
              child: Center(
                child: RaisedButton(
                  onPressed: () {
                    SsiToast.show("失败图标Toast", context,
                        preIcon: Image.asset(
                          "assets/image/icon_toast_fail.png",
                          width: 24,
                          height: 24,
                        ),
                        duration: SsiToast.LENGTH_SHORT);
                  },
                  child: Text("失败图标Toast"),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50, bottom: 50),
              child: Center(
                child: RaisedButton(
                  onPressed: () {
                    SsiToast.show("成功图标Toast", context,
                        preIcon: Image.asset(
                          "assets/image/icon_toast_success.png",
                          width: 24,
                          height: 24,
                        ),
                        duration: SsiToast.LENGTH_SHORT);
                  },
                  child: Text("成功图标Toast"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
