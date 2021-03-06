import 'dart:core';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_ssikit/flutter_ssikit.dart';

/// popup window 位于 targetView 的方向
enum SsiPopupDirection {
  /// 箭头朝上
  top,

  /// 箭头朝下
  bottom
}

/// 通用 Popup Window 提示，带三角号
class SsiPopupWindow extends StatefulWidget {
  /// 依附的组件的Context
  final BuildContext context;

  /// 箭头的高度
  final double arrowHeight;

  /// 要显示的文本
  final String? text;

  /// 依附的组件和SsiPopUpWindow组件共同持有的GlobalKey
  final GlobalKey popKey;

  /// 要显示文本的样式
  final TextStyle? textStyle;

  /// popUpWindow的背景颜色
  final Color? backgroundColor;

  /// 边框颜色
  final Color? borderColor;

  /// 是否有关闭图标
  final bool isShowCloseIcon;

  /// 距离targetView偏移量
  final double offset;

  /// popUpWindow位于targetView的方向
  final SsiPopupDirection popDirection;

  /// 自定义widget
  final Widget? widget;

  /// 容器内边距
  final EdgeInsets? paddingInsets;

  /// 容器圆角
  final double borderRadius;

  /// 是否能多行显示  默认false:单行显示
  final bool canWrap;

  /// 默认距离TargetView边线的距离,默认：20
  final double spaceMargin;

  /// 箭头偏移量
  final double? arrowOffset;

  /// popUpWindow消失回调
  final VoidCallback? onDismiss;

  /// popWindow距离底部的距离小于此值的时候，
  /// 自动将popWindow在targetView上面弹出
  final double turnOverFromBottom;

  const SsiPopupWindow(this.context,
      {this.text,
      required this.popKey,
      this.arrowHeight = 6.0,
      this.textStyle,
      this.backgroundColor,
      this.isShowCloseIcon = false,
      this.offset = 0,
      this.popDirection = SsiPopupDirection.bottom,
      this.widget,
      this.paddingInsets,
      this.borderRadius = 4,
      this.borderColor,
      this.canWrap = false,
      this.spaceMargin = 20,
      this.arrowOffset,
      this.onDismiss,
      this.turnOverFromBottom = 50.0});

  // 显示popUpWindow
  static void showPopWindow(context, String? text, GlobalKey popKey,
      {SsiPopupDirection popDirection = SsiPopupDirection.bottom,
      double arrowHeight = 6.0,
      TextStyle textStyle = const TextStyle(fontSize: 16, color: Color(0xFFFFFFFF)),
      Color backgroundColor = const Color(0xFF1A1A1A),
      bool hasCloseIcon = false,
      double offset = 0,
      Widget? widget,
      EdgeInsets paddingInsets = const EdgeInsets.only(left: 18, top: 14, right: 18, bottom: 14),
      double borderRadius = 8,
      Color? borderColor = Colors.transparent,
      double borderWidth = 1,
      bool canWrap = false,
      double spaceMargin = 20,
      double? arrowOffset,
      VoidCallback? dismissCallback,
      double turnOverFromBottom = 50.0}) {
    Navigator.push(
        context,
        SsiPopupRoute(
            child: SsiPopupWindow(
          context,
          arrowHeight: arrowHeight,
          text: text,
          popKey: popKey,
          textStyle: textStyle,
          backgroundColor: backgroundColor,
          isShowCloseIcon: hasCloseIcon,
          offset: offset,
          popDirection: popDirection,
          widget: widget,
          paddingInsets: paddingInsets,
          borderRadius: borderRadius,
          borderColor: borderColor ?? Colors.transparent,
          canWrap: canWrap,
          spaceMargin: spaceMargin,
          arrowOffset: arrowOffset,
          onDismiss: dismissCallback,
          turnOverFromBottom: turnOverFromBottom,
        )));
  }

  @override
  _SsiPopupWindowState createState() => _SsiPopupWindowState();
}

class _SsiPopupWindowState extends State<SsiPopupWindow> {
  /// targetView的位置
  late Rect _showRect;

  /// 屏幕的尺寸
  late Size _screenSize;

  /// 箭头和左右侧边线间距
  final double _arrowSpacing = 18;

  /// 是否向右侧延伸，true：向右侧延伸，false：向左侧延伸
  bool _expandedRight = true;

  /// popUpWindow在中线两侧的具体位置
  late double _left, _right, _top, _bottom;

  /// 箭头展示方向
  late SsiPopupDirection _popDirection;

  /// 去除透明度的边框色
  Color? _borderColor;

  /// 去除透明度的背景颜色
  Color? _backgroundColor;

  @override
  void initState() {
    super.initState();
    _showRect = _getWidgetGlobalRect(widget.popKey) ?? Rect.zero;
    _screenSize = window.physicalSize / window.devicePixelRatio;
    _borderColor = widget.borderColor?.withAlpha(255);
    _backgroundColor = widget.backgroundColor?.withAlpha(255);
    _popDirection = widget.popDirection;
    _calculateOffset();
  }

  // 获取targetView的位置
  Rect? _getWidgetGlobalRect(GlobalKey key) {
    RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      return null;
    }
    var offset = renderBox.localToGlobal(Offset.zero);
    return Rect.fromLTWH(offset.dx, offset.dy, renderBox.size.width, renderBox.size.height);
  }

  // 计算popUpWindow显示的位置
  void _calculateOffset() {
    if (_showRect.center.dx < _screenSize.width / 2) {
      // popUpWindow向右侧延伸
      _expandedRight = true;
      _left = _showRect.left + widget.spaceMargin;
    } else {
      // popUpWindow向左侧延伸
      _expandedRight = false;
      _right = _screenSize.width - _showRect.right + widget.spaceMargin;
    }
    if (_popDirection == SsiPopupDirection.bottom) {
      // 在targetView下方
      _top = _showRect.height + _showRect.top + widget.offset;
      if ((_screenSize.height - _top) < widget.turnOverFromBottom) {
        _popDirection = SsiPopupDirection.top;
        _bottom = _screenSize.height - _showRect.top + widget.offset;
      }
    } else if (_popDirection == SsiPopupDirection.top) {
      // 在targetView上方
      _bottom = _screenSize.height - _showRect.top + widget.offset;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      excluding: true,
      child: WillPopScope(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.pop(context);
              if (widget.onDismiss != null) {
                widget.onDismiss!();
              }
            },
            child: Material(
              color: Colors.transparent,
              child: Stack(
                children: <Widget>[
                  _buildPopWidget(),
                  // triangle arrow
                  _buildArrowWidget(),
                ],
              ),
            ),
          ),
          onWillPop: () {
            if (widget.onDismiss != null) {
              widget.onDismiss!();
            }
            return Future.value(true);
          }),
    );
  }

  // 绘制箭头
  Widget _buildArrowWidget() {
    return _expandedRight
        ? Positioned(
            left: widget.arrowOffset ??
                _left + (_showRect.width - _arrowSpacing) / 2 - widget.spaceMargin,
            top: _popDirection == SsiPopupDirection.bottom ? _top - widget.arrowHeight : null,
            bottom: _popDirection == SsiPopupDirection.top ? _bottom - widget.arrowHeight : null,
            child: CustomPaint(
              size: Size(15.0, widget.arrowHeight),
              painter: _TrianglePainter(
                  isDownArrow: _popDirection == SsiPopupDirection.top,
                  color: _backgroundColor ?? const Color(0xFF1A1A1A),
                  borderColor: _borderColor ?? Colors.transparent),
            ),
          )
        : Positioned(
            right: widget.arrowOffset ??
                _right + (_showRect.width - _arrowSpacing) / 2 - widget.spaceMargin,
            top: _popDirection == SsiPopupDirection.bottom ? _top - widget.arrowHeight : null,
            bottom: _popDirection == SsiPopupDirection.top ? _bottom - widget.arrowHeight : null,
            child: CustomPaint(
              size: Size(15.0, widget.arrowHeight),
              painter: _TrianglePainter(
                  isDownArrow: _popDirection == SsiPopupDirection.top,
                  color: _backgroundColor ?? const Color(0xFF1A1A1A),
                  borderColor: _borderColor ?? Colors.transparent),
            ),
          );
  }

  // popWindow的弹出样式
  Widget _buildPopWidget() {
    // 状态栏高度
    double statusBarHeight = MediaQueryData.fromWindow(window).padding.top;
    return Positioned(
        left: _expandedRight ? _left : null,
        right: _expandedRight ? null : _right,
        top: _popDirection == SsiPopupDirection.bottom ? _top : null,
        bottom: _popDirection == SsiPopupDirection.top ? _bottom : null,
        child: Container(
            padding: widget.paddingInsets,
            decoration: BoxDecoration(
                color: _backgroundColor,
                border: Border.all(color: _borderColor ?? Colors.transparent, width: 0.5),
                borderRadius: BorderRadius.circular(widget.borderRadius)),
            constraints: BoxConstraints(
                maxWidth: _expandedRight ? _screenSize.width - _left : _screenSize.width - _right,
                maxHeight: _popDirection == SsiPopupDirection.bottom
                    ? _screenSize.height - _top
                    : _screenSize.height - _bottom - statusBarHeight),
            child: widget.widget ?? (SingleChildScrollView(
                    child: widget.canWrap
                        ? RichText(
                            text: TextSpan(children: <InlineSpan>[
                            TextSpan(text: widget.text, style: widget.textStyle),
                            widget.isShowCloseIcon
                                ? WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 6),
                                      child: SsikitTools.getAssetImage(SsiAsset.ICON_POPUP_CLOSE),
                                    ))
                                : const TextSpan(text: '')
                          ]))
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Flexible(
                                fit: FlexFit.loose,
                                child: Text(
                                  widget.text ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: widget.textStyle,
                                ),
                              ),
                              widget.isShowCloseIcon
                                  ? Padding(
                                      padding: EdgeInsets.only(left: 6),
                                      child: SsikitTools.getAssetImage(SsiAsset.ICON_POPUP_CLOSE),
                                    )
                                  : Text('')
                            ],
                          )))));
  }
}

// 绘制箭头
class _TrianglePainter extends CustomPainter {
  bool isDownArrow;
  Color color;
  Color borderColor;

  _TrianglePainter({
    this.isDownArrow = true,
    required this.color,
    required this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();
    paint.strokeWidth = 2.0;
    paint.color = color;
    paint.style = PaintingStyle.fill;

    if (isDownArrow) {
      path.moveTo(0.0, -1.5);
      path.lineTo(size.width / 2.0, size.height);
      path.lineTo(size.width, -1.5);
    } else {
      path.moveTo(0.0, size.height + 1.5);
      path.lineTo(size.width / 2.0, 0.0);
      path.lineTo(size.width, size.height + 1.5);
    }

    canvas.drawPath(path, paint);
    Paint paintBorder = Paint();
    Path pathBorder = Path();
    paintBorder.strokeWidth = 0.5;
    paintBorder.color = borderColor;
    paintBorder.style = PaintingStyle.stroke;

    if (isDownArrow) {
      pathBorder.moveTo(0.0, -0.5);
      pathBorder.lineTo(size.width / 2.0, size.height);
      pathBorder.lineTo(size.width, -0.5);
    } else {
      pathBorder.moveTo(0.5, size.height + 0.5);
      pathBorder.lineTo(size.width / 2.0, 0);
      pathBorder.lineTo(size.width - 0.5, size.height + 0.5);
    }

    canvas.drawPath(pathBorder, paintBorder);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class SsiPopupRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 200);
  Widget child;

  SsiPopupRoute({required this.child});

  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}

/// popup 中每个 Item 被点击时的回调，
/// [index] Item 的索引
/// [item] Item 内容
typedef SsiPopupListItemClick = Function(int index, String item);

/// popup 用于构造自定义的 Item
/// [index] Item 的索引
/// [item] Item 内容
typedef SsiPopupListItemBuilder = Widget? Function(int index, String item);

/// 基于 PopUpWindow 的 弹窗列表工具类
class SsiPopupListWindow {

  /// 带 itemBuilder 的 Popup List Window
  /// [popKey] 依附的组件和SsiPopUpWindow组件共同持有的GlobalKey
  /// [data] 要显示的文本数据列表
  /// [popDirection] 箭头的方向
  /// [itemBuilder] 自定义 item 构造方法
  /// [onItemClick] item 点击回调
  static void showButtonPanelPopList(context, GlobalKey popKey,
      {required List<String> data,
      SsiPopupDirection popDirection = SsiPopupDirection.bottom,
      SsiPopupListItemBuilder? itemBuilder,
      SsiPopupListItemClick? onItemClick}) {
    TextStyle textStyle = TextStyle(
        color: SsiThemeConfigurator.instance.getConfig()?.commonConfig?.colorTextBase, fontSize: 16);
    double arrowHeight = 6.0;
    Color? borderColor = const Color(0xffCCCCCC);
    Color backgroundColor = Colors.white;
    double offset = 4;
    double spaceMargin = -10;
    double minWidth = 100;
    double maxWidth = 150;
    double maxHeight = 200;
    double borderRadius = 4;
    bool hasCloseIcon = true;
    Navigator.push(
        context,
        SsiPopupRoute(
            child: SsiPopupWindow(
          context,
          arrowHeight: arrowHeight,
          popKey: popKey,
          textStyle: textStyle,
          backgroundColor: backgroundColor,
          isShowCloseIcon: hasCloseIcon,
          offset: offset,
          widget: SsikitTools.isEmpty(data)
              ? Container(
                  constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
                )
              : Container(
                  constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.only(top: 6, bottom: 6),
                      child: Column(
                        children: _getItems(context, minWidth, maxWidth, itemBuilder, textStyle,
                            data, onItemClick, null),
                      ),
                    ),
                  ),
                ),
          popDirection: popDirection,
          borderRadius: borderRadius,
          borderColor: borderColor,
          spaceMargin: spaceMargin,
        )));
  }

  /// 显示Popup List Window
  /// [popKey] 依附的组件和SsiPopUpWindow组件共同持有的GlobalKey
  /// [data] 要显示的文本数据列表
  /// [popDirection] 箭头的方向
  /// [offset] 距离targetView偏移量
  /// [spaceMarginOffset] 距离PopWidget偏移量
  /// [onItemClick] item 点击回调
  /// [onDismiss] popUpWindow消失回调
  static void showPopListWindow(context, GlobalKey popKey,
      {required List<String> data,
      SsiPopupDirection popDirection = SsiPopupDirection.bottom,
      double offset = 0,
      double spaceMarginOffset = 0,
      SsiPopupListItemClick? onItemClick,
      VoidCallback? onDismiss}) {
        assert(spaceMarginOffset >= 0);
    double arrowHeight = 6.0;
    double borderRadius = 4;
    double spaceMargin = 0 + spaceMarginOffset;
    double minWidth = 100;
    double maxWidth = 150;
    double maxHeight = 200;
    double? arrowOffset;
    Color? borderColor = SsiThemeConfigurator.instance.getConfig()?.commonConfig?.dividerColorBase;
    Color? backgroundColor = Colors.white;
    TextStyle textStyle = TextStyle(
        color: SsiThemeConfigurator.instance.getConfig()?.commonConfig?.colorTextBase, fontSize: 14);
    bool hasCloseIcon = true;

    Navigator.push(
        context,
        SsiPopupRoute(
            child: SsiPopupWindow(
          context,
          arrowHeight: arrowHeight,
          popKey: popKey,
          textStyle: textStyle,
          backgroundColor: backgroundColor,
          arrowOffset: arrowOffset,
          isShowCloseIcon: hasCloseIcon,
          offset: offset,
          widget: SsikitTools.isEmpty(data)
              ? Container(
                  constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
                )
              : Container(
                  constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.only(top: 6, bottom: 6),
                      child: Column(
                        children: _getItems(context, minWidth, maxWidth, null, textStyle, data,
                            onItemClick, onDismiss),
                      ),
                    ),
                  ),
                ),
          popDirection: popDirection,
          borderRadius: borderRadius,
          borderColor: borderColor,
          spaceMargin: spaceMargin,
          onDismiss: onDismiss,
        )));
  }

  static List<Widget> _getItems(
      BuildContext context,
      double minWidth,
      double maxWidth,
      SsiPopupListItemBuilder? itemBuilder,
      TextStyle? textStyle,
      List<String> data,
      SsiPopupListItemClick? onItemClick,
      VoidCallback? onDismiss) {
    double textMaxWidth =
        _getMaxWidth(textStyle ?? const TextStyle(fontSize: 16, color: Color(0xFFFFFFFF)), data);
    if (textMaxWidth + 52 < minWidth) {
      textMaxWidth = minWidth;
    } else if (textMaxWidth + 52 > maxWidth) {
      textMaxWidth = maxWidth;
    } else {
      textMaxWidth = textMaxWidth + 52;
    }
    return data.map((f) {
          return GestureDetector(
              onTap: () {
                if (onItemClick != null) {
                  dynamic isIntercept = onItemClick(data.indexOf(f), f);
                  if ((isIntercept is bool) && isIntercept) return;
                }
                Navigator.pop(context);
                if (onDismiss != null) {
                  onDismiss();
                }
              },
              child: Container(
                  width: textMaxWidth,
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  padding: const EdgeInsets.only(left: 26, right: 26, top: 6, bottom: 6),
                  child: _getTextWidget(itemBuilder, data, f, textStyle)));
        }).toList();
  }

  /// 遍历数据，计算每个 Item 内容，返回所有 Item 可展示的最大宽度
  static double _getMaxWidth(TextStyle textStyle, List<String> data) {
    double maxWidth = 0;
    if (!SsikitTools.isEmpty(data)) {
      Size? maxWidthSize;
      for (String entity in data) {
        Size size = SsikitTools.textSize(entity, textStyle);
        if (maxWidthSize == null) {
          maxWidthSize = size;
        } else {
          if (maxWidthSize.width < size.width) {
            maxWidthSize = size;
          }
        }
      }
      maxWidth = maxWidthSize?.width ?? 0;
    }
    return maxWidth;
  }

  static Widget _getTextWidget(
      SsiPopupListItemBuilder? itemBuilder, List<String> data, String text, TextStyle? textStyle) {
    if (itemBuilder == null) {
      return _getDefaultText(text, textStyle);
    } else {
      return itemBuilder(data.indexOf(text), text) ?? _getDefaultText(text, textStyle);
    }
  }

  static Text _getDefaultText(String text, TextStyle? textStyle) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: textStyle ??
          const TextStyle(
            fontSize: 16,
            color: Color(0xFFFFFFFF),
          ),
    );
  }
}
