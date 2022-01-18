import 'dart:core';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'ssi_measure_size.dart';

/// popWindow位于targetView的方向
enum SsiOverlayPopDirection { none, top, bottom, left, right }

/// * 描述: Overlay 工具类。
class SsiOverlayWindow extends StatefulWidget {
  final BuildContext context;

  /// 锚点 Widget 的 key，用于 OverlayWindow 的定位
  final Key targetKey;

  /// OverlayWindow 相对于 key 的展示位置， 默认 bottom
  final SsiOverlayPopDirection popDirection;

  /// 要展示的内容
  final Widget content;

  const SsiOverlayWindow({
    required this.context,
    required this.targetKey,
    this.popDirection = SsiOverlayPopDirection.bottom,
    required this.content,
  });

  @override
  State<StatefulWidget> createState() {
    return _SsiOverlayWindowState();
  }

  /// SsiOverlayWindow 工具方发，用于快速弹出 Overlay，
  /// 返回 [SsiOverlayController] 用于控制 Overlaywindow 的隐藏
  /// [targetKey] 锚点 Widget 的 key，用于 OverlayWindow 的定位
  /// [popDirection] OverlayWindow 相对于 key 的展示位置， 默认 bottom
  /// [content] 要展示的内容
  /// [autoDismissOnTouchOutSide] 点击 OverlayWindow 外部是否自动消失
  /// [onDismiss] OverlayWindow 消失回调
  static SsiOverlayController? showOverlayWindow(BuildContext context, Key targetKey,
      {required Widget content,
      SsiOverlayPopDirection popDirection = SsiOverlayPopDirection.bottom,
      bool autoDismissOnTouchOutSide = true,
      Function? onDismiss}) {
    SsiOverlayController? overlayController;
    OverlayEntry entry = OverlayEntry(builder: (context) {
      return GestureDetector(
          behavior: (autoDismissOnTouchOutSide)
              ? HitTestBehavior.opaque
              : HitTestBehavior.deferToChild,
          onTap: (autoDismissOnTouchOutSide)
              ? () {
                  overlayController?.removeOverlay();
                  if (onDismiss != null) {
                    onDismiss();
                  }
                }
              : null,
          child: SsiOverlayWindow(
            context: context,
            content: content,
            targetKey: targetKey,
            popDirection: popDirection,
          ));
    });

    overlayController = SsiOverlayController._(context, entry)..showOverlay();
    return overlayController;
  }
}

class _SsiOverlayWindowState extends State<SsiOverlayWindow> {
  /// targetView的位置
  late Rect _showRect;

  /// 屏幕的尺寸
  late Size _screenSize;

  /// overlay 在targetView 四周的偏移位置
  late double _left, _right, _top, _bottom;

  /// targetView 的 Size
  Size _targetViewSize = Size.zero;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _showRect = _getWidgetGlobalRect(widget.targetKey as GlobalKey) ?? Rect.zero;
    _screenSize = window.physicalSize / window.devicePixelRatio;
    _calculateOffset();
    return _buildContent();
  }

  Widget _buildContent() {
    var contentPart = Material(
        color: Colors.transparent,
        child: MeasureSize(
            onChange: (size) {
              setState(() {
                _targetViewSize = size!;
              });
            },
            child: widget.content));
    var placeHolderPart = GestureDetector();
    Widget realContent;

    double marginTop = _showRect.top + (_showRect.height - _targetViewSize.height) / 2;
    if (_screenSize.height - marginTop < _targetViewSize.height) {
      marginTop = max(0, _screenSize.height - _targetViewSize.height);
    }
    marginTop = max(0, marginTop);

    double marginLeft = _showRect.left + (_showRect.width - _targetViewSize.width) / 2;
    if (_screenSize.width - marginLeft < _targetViewSize.width) {
      marginLeft = max(0, _screenSize.width - _targetViewSize.width);
    }
    marginLeft = max(0, marginLeft);

    if (widget.popDirection == SsiOverlayPopDirection.left) {
      realContent = Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Container(
                padding: EdgeInsets.only(top: marginTop),
                alignment: Alignment.topRight,
                child: contentPart),
            flex: _left.toInt(),
          ),
          Expanded(
            child: placeHolderPart,
            flex: (_screenSize.width - _left).toInt(),
          )
        ],
      );
    } else if (widget.popDirection == SsiOverlayPopDirection.right) {
      realContent = Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: placeHolderPart,
            flex: (_right).toInt(),
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.only(top: marginTop),
                alignment: Alignment.topLeft,
                child: contentPart),
            flex: (_screenSize.width - _right).toInt(),
          )
        ],
      );
    } else if (widget.popDirection == SsiOverlayPopDirection.top) {
      realContent = Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Container(
                padding: EdgeInsets.only(top: marginLeft),
                alignment: Alignment.bottomLeft,
                child: contentPart),
            flex: _top.toInt(),
          ),
          Expanded(
            child: placeHolderPart,
            flex: (_screenSize.height - _top).toInt(),
          )
        ],
      );
    } else {
      realContent = Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: placeHolderPart,
            flex: _bottom.toInt(),
          ),
          Expanded(
            child: Container(alignment: Alignment.topLeft, child: contentPart),
            flex: (_screenSize.height - _bottom).toInt(),
          )
        ],
      );
    }
    return realContent;
  }

  ///
  /// 获取targetView的位置
  ///
  Rect? _getWidgetGlobalRect(GlobalKey key) {
    RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      return null;
    }
    var offset = renderBox.localToGlobal(Offset.zero);
    return Rect.fromLTWH(offset.dx, offset.dy, renderBox.size.width, renderBox.size.height);
  }

  ///
  /// 计算popUpWindow显示的位置
  ///
  void _calculateOffset() {
    _right = _left = _top = _bottom = 0;
    if (widget.popDirection == SsiOverlayPopDirection.left) {
      _left = _showRect.left;
    } else if (widget.popDirection == SsiOverlayPopDirection.right) {
      _right = _showRect.right;
    } else if (widget.popDirection == SsiOverlayPopDirection.bottom) {
      _bottom = _showRect.bottom;
    } else if (widget.popDirection == SsiOverlayPopDirection.top) {
      // 在targetView上方
      _top = _showRect.top;
    }
  }
}

class SsiOverlayController {
  OverlayEntry? _entry;

  BuildContext context;
  bool _isOverlayShowing = false;

  bool get isOverlayShowing => _isOverlayShowing;

  SsiOverlayController._(this.context, this._entry);

  showOverlay() {
    if (_entry == null) {
      return;
    }
    Overlay.of(context)?.insert(_entry!);
    _isOverlayShowing = true;
  }

  void removeOverlay() {
    _entry?.remove();
    _entry = null;
    _isOverlayShowing = false;
  }
}
