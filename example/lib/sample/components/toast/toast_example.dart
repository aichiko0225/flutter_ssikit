import 'package:flutter/material.dart';
import 'package:flutter_ssikit/flutter_ssikit.dart';

class ToastExample extends StatefulWidget {
  @override
  _ToastExampleState createState() => _ToastExampleState();
}

class _ToastExampleState extends State<ToastExample>
    with TickerProviderStateMixin {

    double _top = 0;

  @override
  void initState() {
    super.initState();
    _top = -36;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SsiToast示例'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 36,
              child: Stack(
                children: <Widget>[
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    top: _top,
                    left: 0,
                    right: 0,
                    height: 36,
                    child: SsiNoticeBar(
                      leftWidget: Image.asset(
                        "assets/image/icon_toast_fail.png",
                        width: 14,
                        height: 14,
                      ),
                      content: '这里是顶部提示内容',
                      showRightIcon: false,
                      backgroundColor: Color(0x88000000),
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, bottom: 50),
              child: Center(
                child: RaisedButton(
                  onPressed: () {
                    SsiToast.show("普通长Toast", context,
                        duration: SsiToast.LENGTH_LONG, gravity: 1);
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
            ),
            RaisedButton(
              onPressed: () {
                SsiLoadingToast.showLoading(context);
              },
              child: Text("显示 loading Toast"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        SsiStatusToast.showSuccess(context, successText: '修改成功',
                            onDismiss: () {
                          debugPrint('onDismiss');
                        });
                      },
                      child: Text('success')),
                  OutlinedButton(
                      onPressed: () {
                        SsiStatusToast.showFailure(context, failureText: '修改失败',
                            onDismiss: () {
                          debugPrint('onDismiss');
                        });
                      },
                      child: Text('failure')),
                  OutlinedButton(
                      onPressed: () {
                        SsiStatusToast.showInfoText(context, message: '状态文本',
                            onDismiss: () {
                          debugPrint('onDismiss');
                        });
                      },
                      child: Text('info_text')),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
              child: Row(
                children: [
                  OutlinedButton(onPressed: () {
                    if (_top == 0) { return; }
                    setState(() {
                      _top = 0;
                    });
                  }, child: Text('显示标题栏下方toast')),
                  OutlinedButton(onPressed: () {
                    if (_top == -36) { return; }
                    setState(() {
                      _top = -36;
                    });
                  }, child: Text('隐藏标题栏下方toast')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
