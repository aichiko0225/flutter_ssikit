import 'package:flutter/material.dart';
import 'package:flutter_ssikit/src/constants/ssi_strings_constants.dart';

enum ToastStatus { info, success, failure }

class SsiPageStatusToast extends StatelessWidget {
  final String? message;

  final ToastStatus toastStatus;

  SsiPageStatusToast({this.message, this.toastStatus = ToastStatus.info});

  static String ASSETS_TOAST_INFO_IMAGE = 'assets/images/toast_info.png';

  static String ASSETS_TOAST_SUCCESS_IMAGE = 'assets/images/toast_success.png';

  static String ASSETS_TOAST_FAILURE_IMAGE = 'assets/images/toast_failure.png';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 180,
        width: 160,
        decoration: BoxDecoration(
            color: Color(0xff222222),
            border: null,
            borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 48,
                width: 48,
                child: Image(
                    image: AssetImage(assetName,
                        package: SsiStrings.flutterPackageName)),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: Text(
                  message ?? "暂无数据",
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

  String get assetName {
    switch (toastStatus) {
      case ToastStatus.info:
        return ASSETS_TOAST_INFO_IMAGE;
      case ToastStatus.success:
        return ASSETS_TOAST_SUCCESS_IMAGE;
      case ToastStatus.failure:
        return ASSETS_TOAST_FAILURE_IMAGE;
      default:
    }
    return ASSETS_TOAST_INFO_IMAGE;
  }
}

/// 通过 [SsiStatusDialog] 构建出的不同状态的弹窗，加载动画和加载文字并列展示，且在屏幕中间。可通
/// 过 [SsiStatusDialog.show] 和 [SsiStatusDialog.dismiss] 控制弹窗的显示和关闭。不会自动关闭。
/// 现在有 success failure info 三种状态，info模式下可以自定义图片和文本，也可以使用custom显示弹框
class SsiStatusToastDialog extends Dialog {
  /// 弹框的提示文案，默认为 `暂无数据`
  final String? message;

  final ToastStatus toastStatus;

  static bool _isShowDialog = false;

  static SsiStatusToastDialog? _statusToastView;

  SsiStatusToastDialog(
      {Key? key, this.message = "暂无数据", this.toastStatus = ToastStatus.info})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SsiPageStatusToast(
      message: message,
      toastStatus: toastStatus,
    );
  }

  /// 展示加载弹窗的静态方法。
  ///
  ///  * [context] 上下文
  ///  * [content] 加载时的提示文案
  ///  * [barrierDismissible] 点击蒙层背景是否关闭弹窗，默认为 true，可关闭，详见 [showDialog] 中的 [barrierDismissible]
  ///  * [barrierColor] 蒙层背景颜色
  ///  * [useRootNavigator] 把弹窗添加到 [context] 中的 rootNavigator 还是最近的 [Navigator]，默认为 true，添加到
  ///    rootNavigator，详见 [showDialog] 中的 [useRootNavigator]。
  static Future<void> show(
    BuildContext context, {
    String? message,
    ToastStatus toastStatus = ToastStatus.info,
    Duration duration = const Duration(seconds: 1),
    VoidCallback? onDismiss,
    bool barrierDismissible = true,
    Color? barrierColor = Colors.black12,
    bool useRootNavigator = true,
  }) async {
    _statusToastView = null;
    
    if (_isShowDialog && _statusToastView != null) {
      return;
    }

    _statusToastView = SsiStatusToastDialog(message: message, toastStatus: toastStatus);
    _isShowDialog = true;

    showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        useRootNavigator: useRootNavigator,
        barrierColor: barrierColor,
        routeSettings: const RouteSettings(name: 'ToastDialog'),
        builder: (_context) {
          return WillPopScope(
            child: _statusToastView!,
            onWillPop: () {
              // 拦截到返回键，证明dialog被手动关闭
              _isShowDialog = false;
              _statusToastView = null;
              if (onDismiss != null) {
                onDismiss();
              }
              return Future.value(true);
            },
          );
        });
    await Future.delayed(duration);
    if (!_isShowDialog && _statusToastView == null) {
      return;
    }
    dismiss(context);
    if (onDismiss != null) {
      onDismiss();
    }
  }

  /// 关闭弹窗。
  ///
  ///  * [context] 上下文。
  static void dismiss(BuildContext context) {
    if (!_isShowDialog) {
      return;
    }
    _isShowDialog = false;
    _statusToastView = null;
    Navigator.pop(context);
  }
}
