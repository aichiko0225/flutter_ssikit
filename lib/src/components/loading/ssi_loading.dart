import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ssikit/src/components/loading/ssi_cupertino_activityIndicator.dart';

/// 页面或者弹窗中间的圆形加载框，左侧是可定制的加载文案[content]，比如：加载中、提交中等等
///
/// 该组件 并不支持获取 指定时刻的动画值
///
/// 页面中使用
/// Scaffold(
///   appBar: SsiAppBar(
///      title: 'Loading案例',
///   ),
///   body: SsiPageLoading(),
/// )
///
/// 对话框中使用
/// showDialog(
///    context: context,
///    barrierDismissible: barrierDismissible,
///    useRootNavigator: useRootNavigator,
///    builder: (_) {
///       return SsiLoadingDialog(content: content);
///    });
///
/// 其他加载组件:
///  * [LinearProgressIndicator], 线性加载组件.
///  * [RefreshIndicator], 刷新组件。
///  * [SsiLoadingDialog], 加载对话框。

class SsiPageLoading extends StatelessWidget {
  final String? content;

  SsiPageLoading({this.content});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 180,
        width: 160,
        decoration: BoxDecoration(
            color: Color(0xff222222), border: null, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 48,
                width: 48,
                child: SsiCupertinoActivityIndicator(
                  radius: 24,
                  valueColor: Colors.white,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: Text(
                  content ?? "加载中...",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      decoration: TextDecoration.none),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


/// 通过 [SsiPageLoading] 构建出的加载状态的弹窗，加载动画和加载文字并排展示，且在屏幕中间。可通
/// 过 [SsiLoadingDialog.show] 和 [SsiLoadingDialog.dismiss] 控制弹窗的显示和关闭。不会自动关闭。
class SsiLoadingDialog extends Dialog {
  /// 加载时的提示文案，默认为 `加载中...`
  final String? content;

  SsiLoadingDialog({Key? key, this.content = "加载中..."}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SsiPageLoading(content: content);
  }

  /// 展示加载弹窗的静态方法。
  ///
  ///  * [context] 上下文
  ///  * [content] 加载时的提示文案
  ///  * [barrierDismissible] 点击蒙层背景是否关闭弹窗，默认为 true，可关闭，详见 [showDialog] 中的 [barrierDismissible]
  ///  * [barrierColor] 蒙层背景颜色
  ///  * [useRootNavigator] 把弹窗添加到 [context] 中的 rootNavigator 还是最近的 [Navigator]，默认为 true，添加到
  ///    rootNavigator，详见 [showDialog] 中的 [useRootNavigator]。
  static void show(
      BuildContext context, {
        String? content,
        bool barrierDismissible = true,
        Color? barrierColor = Colors.black54,
        bool useRootNavigator = true,
      }) {
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        useRootNavigator: useRootNavigator,
        barrierColor: barrierColor,
        builder: (_) {
          return SsiLoadingDialog(content: content);
        });
  }

  /// 关闭弹窗。
  ///
  ///  * [context] 上下文。
  static void dismiss(BuildContext context) {
    Navigator.pop(context);
  }
}
