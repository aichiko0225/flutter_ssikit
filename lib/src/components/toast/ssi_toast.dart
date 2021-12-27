// ignore_for_file: unnecessary_null_comparison, constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_ssikit/src/components/loading/ssi_loading.dart';
import 'package:flutter_ssikit/src/components/loading/ssi_status_dialog.dart';

/// 通用的Toast组件
class SsiToast {
  static const LENGTH_SHORT = 1;
  static const LENGTH_LONG = 2;
  static const BOTTOM = 0;
  static const CENTER = 1;
  static const TOP = 2;

  static _ToastView? preToastView;

  /// 显示在中间。如不设置duration则会自动根据内容长度来计算（更友好，最长5秒）
  static void showInCenter(String text, BuildContext context, {int? duration}) {
    show(text, context, duration: duration, gravity: CENTER);
  }

  /// 显示Toast，如不设置duration则会自动根据内容长度来计算（更友好，最长5秒）
  static void show(String text, BuildContext context,
      {int? duration,
      int gravity = BOTTOM,
      Color backgroundColor = const Color(0xFF222222),
      textStyle = const TextStyle(fontSize: 16, color: Colors.white),
      double backgroundRadius = 8,
      Image? preIcon,
      double verticalOffset = 0,
      VoidCallback? onDismiss}) {
    OverlayState? overlayState = Overlay.of(context);
    if (text == null || context == null || overlayState == null) {
      return;
    }
    preToastView?._dismiss();
    preToastView = null;

    verticalOffset = getRealVerticalOffset(verticalOffset, gravity, context);
    // 自动根据内容长度决定显示时长，更加人性化
    int aiDuration = duration ?? min(text.length * 0.06 + 0.8, 5.0).ceil();

    _ToastView toastView = _ToastView();
    toastView.overlayState = overlayState;
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(builder: (context) {
      return _buildToastLayout(context, backgroundColor, backgroundRadius,
          preIcon, text, textStyle, gravity,
          verticalOffset: verticalOffset);
    });
    toastView._overlayEntry = overlayEntry;
    preToastView = toastView;
    toastView._show(aiDuration, onDismiss: onDismiss);
  }

  static double getRealVerticalOffset(
      double verticalOffset, int gravity, BuildContext context) {
    if (gravity == SsiToast.TOP) {
      verticalOffset =
          (verticalOffset) + MediaQuery.of(context).viewInsets.top + 50;
    } else if (gravity == SsiToast.BOTTOM) {
      verticalOffset =
          (verticalOffset) + MediaQuery.of(context).viewInsets.bottom + 50;
    } else {
      verticalOffset = 0;
    }
    return verticalOffset;
  }
}

/// 显示loading toast 的扩展方法
extension SsiLoadingToast on SsiToast {
  /// 展示加载弹窗的静态方法。
  ///
  ///  * [context] 上下文
  ///  * [content] 加载时的提示文案
  ///  * [barrierDismissible] 点击蒙层背景是否关闭弹窗，默认为 true，可关闭，详见 [showDialog] 中的 [barrierDismissible]
  ///  * [barrierColor] 蒙层背景颜色
  ///  * [useRootNavigator] 把弹窗添加到 [context] 中的 rootNavigator 还是最近的 [Navigator]，默认为 true，添加到
  ///    rootNavigator，详见 [showDialog] 中的 [useRootNavigator]。
  static void showLoading(
    BuildContext context, {
    String? content,
    bool barrierDismissible = true,
    Color? barrierColor = Colors.black54,
    bool useRootNavigator = true,
  }) {
    SsiLoadingDialog.show(context,
        content: content,
        barrierDismissible: barrierDismissible,
        useRootNavigator: useRootNavigator,
        barrierColor: barrierColor);
  }

  /// 关闭弹窗。
  ///
  ///  * [context] 上下文。
  static void dismiss(BuildContext context) {
    SsiLoadingDialog.dismiss(context);
  }
}

/// 显示不同状态的 toast
extension SsiStatusToast on SsiToast {

  static void showSuccess(BuildContext context,
      {String? successText,
      Duration duration = const Duration(seconds: 1),
      VoidCallback? onDismiss}) {
    SsiStatusToastDialog.show(context,
        message: successText,
        toastStatus: ToastStatus.success,
        duration: duration,
        onDismiss: onDismiss);
  }

  static void showFailure(BuildContext context,
      {String? failureText,
      Duration duration = const Duration(seconds: 1),
      VoidCallback? onDismiss}) {
    SsiStatusToastDialog.show(context,
        message: failureText,
        toastStatus: ToastStatus.failure,
        duration: duration,
        onDismiss: onDismiss);
  }

  static void showInfoText(BuildContext context,
      {String? message,
      Duration duration = const Duration(seconds: 1),
      VoidCallback? onDismiss}) {
    SsiStatusToastDialog.show(context,
        message: message,
        toastStatus: ToastStatus.info,
        duration: duration,
        onDismiss: onDismiss);
  }
}

_ToastWidget _buildToastLayout(
    BuildContext context,
    Color background,
    double backgroundRadius,
    Image? preIcon,
    String msg,
    TextStyle textStyle,
    int gravity,
    {double verticalOffset = 0}) {
  Alignment alignment = Alignment.center;
  EdgeInsets padding = EdgeInsets.all(0);
  if (gravity == SsiToast.BOTTOM) {
    alignment = Alignment.bottomCenter;
    padding = EdgeInsets.only(bottom: verticalOffset);
  } else if (gravity == SsiToast.TOP) {
    alignment = Alignment.topCenter;
    padding = EdgeInsets.only(top: verticalOffset);
  }

  return _ToastWidget(
      widget: Container(
        width: MediaQuery.of(context).size.width,
        child: Container(
            padding: padding,
            alignment: alignment,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(backgroundRadius),
              ),
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.fromLTRB(18, 10, 18, 10),
              child: RichText(
                text: TextSpan(children: <InlineSpan>[
                  preIcon != null
                      ? WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Padding(
                            padding: EdgeInsets.only(right: 6),
                            child: preIcon,
                          ))
                      : TextSpan(text: ""),
                  TextSpan(text: msg, style: textStyle),
                ]),
              ),
            )),
      ),
      gravity: gravity);
}

class _ToastView {
  OverlayState? overlayState;
  OverlayEntry? _overlayEntry;
  bool _isVisible = false;

  _show(int? duration, {VoidCallback? onDismiss}) async {
    _isVisible = true;
    if (_overlayEntry == null) {
      return;
    }
    overlayState?.insert(_overlayEntry!);
    await Future.delayed(Duration(seconds: duration ?? SsiToast.LENGTH_SHORT));
    _dismiss();
    if (onDismiss != null) {
      onDismiss();
    }
  }

  _dismiss() async {
    if (!_isVisible) {
      return;
    }
    _isVisible = false;
    _overlayEntry?.remove();
  }
}

class _ToastWidget extends StatelessWidget {
  final Widget widget;
  final int gravity;

  _ToastWidget({
    Key? key,
    required this.widget,
    required this.gravity,
  }) : super(key: key);

  // 使用IgnorePointer，方便手势透传过去
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Material(
        color: Colors.transparent,
        child: widget,
      ),
    );
  }
}
