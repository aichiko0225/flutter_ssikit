import 'package:flutter/material.dart';
import 'package:flutter_ssikit/src/components/dialog/ssi_dialog_utils.dart';
import 'package:flutter_ssikit/src/theme/configs/ssi_dialog_config.dart';
import '../../../flutter_ssikit.dart';

/// 底部按钮的点击监听回调
typedef DialogIndexedActionClickCallback = void Function(int index);

/// icon的间距
const EdgeInsetsGeometry cIconPadding = EdgeInsets.only(top: 28.0);

/// title的文字样式
const TextStyle cTitleTextStyle = TextStyle(
    fontWeight: FontWeight.w600,
    inherit: true,
    fontSize: 18.0,
    color: Color(0xFF222222));

/// title的文字的对齐
const int cTitleMaxLines = 3;

/// title的文字的对齐
const TextAlign cTitleTextAlign = TextAlign.center;

/// 内容部分文字的对齐
const TextAlign cContentTextAlign = TextAlign.center;

/// 内容部分的文字的样式
const TextStyle cContentTextStyle = TextStyle(
    inherit: true,
    fontSize: 14.0,
    color: Color(0xFF666666),
    decoration: TextDecoration.none);

/// 警示文案样式
const TextStyle cWarningTextStyle = TextStyle(
    inherit: true,
    fontSize: 14.0,
    color: Color(0xFFFA3F3F),
    decoration: TextDecoration.none);

/// 警示文案的文字对齐
const TextAlign cWarningTextAlign = TextAlign.center;

/// 对话框的背景---》默认白色
const Color cBackgroundColor = Colors.white;

/// 对话框的边框----》默认圆角5
const ShapeBorder cShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5.0)));

/// 主题按钮的背景颜色---》白色
const Color cMainBackgroundColor = Colors.white;

/// 主题按钮的文字样式---》主色调
const TextStyle cMainTextStyle = TextStyle(
    color: Color(0xFF00AE66), fontWeight: FontWeight.w600, fontSize: 16);

/// 灰色按钮的背景颜色---》白色
const Color cGreyBackgroundColor = Colors.white;

/// 非按钮的文字样式---》灰色
const TextStyle cGreyActionsTextStyle = TextStyle(
    color: Color(0xFF222222), fontWeight: FontWeight.w600, fontSize: 16);

/// 底部按钮的高度
const double cBottomHeight = 44.0;

/// 水平分割线 内容与按钮
const VerticalDivider cVerticalDivider =
    VerticalDivider(width: 1.0, color: Color(0xF0F0F0F0));

/// 垂直分割线 按钮分割
const Divider cDividerLine = Divider(
  height: 1.0,
  color: Color(0xF0F0F0F0),
);

enum ButtonType {
  /// 单按钮
  Single,

  /// 多按钮
  Multi,

  /// 左按钮
  Left,

  /// 右按钮
  Right,
}

/// 对话框的样式
class SsiDialogStyle {
  /// title的间距
  EdgeInsets? titlePadding;

  /// 主色调按钮样式
  TextStyle? mainTextStyle;

  /// 主色调按钮的背景
  Color? mainBackgroundColor;

  /// 其他按钮的样式
  TextStyle? greyActionsTextStyle;

  /// 其他按钮的背景
  Color? greyActionsBackgroundColor;

  /// 标题的文字样式
  TextStyle? titleTextStyle;

  /// 标题的文字对齐
  TextAlign? titleTextAlign;

  /// 内容文字的对齐
  TextAlign? contentTextAlign;

  /// 内容widget的间距
  EdgeInsets? contentPadding;

  /// 内容文字的样式
  TextStyle? contentTextStyle;

  /// 对话框的背景
  Color? backgroundColor;

  /// 对话框的底部按钮的高度
  double? bottomHeight;

  /// 对话框圆角的大小
  double? radius;

  /// 边框阴影
  double? elevation;

  /// 警示文案的样式
  TextStyle? warningTextStyle;

  /// 警示文案文字的对齐
  TextAlign? warningTextAlign;

  /// 警示文案的间距
  EdgeInsets? warningPadding;

  /// icon的间距
  EdgeInsets? iconPadding;

  /// 标题最大行数
  int? titleMaxLines;

  SsiDialogStyle({
    this.titlePadding,
    this.titleTextAlign,
    this.titleTextStyle,
    this.contentPadding,
    this.contentTextStyle,
    this.warningTextStyle,
    this.backgroundColor,
    this.contentTextAlign,
    this.mainBackgroundColor,
    this.mainTextStyle,
    this.greyActionsBackgroundColor,
    this.greyActionsTextStyle,
    this.bottomHeight,
    this.warningPadding,
    this.warningTextAlign,
    this.iconPadding,
    this.radius,
  });
}

///高度灵活的通用的弹窗组件
///
///布局规则：
///   弹窗由五部分组成：Icon、标题、内容、警示、按钮操作区域。
///   每一部分都可以显示或者不显示。
///
///弹窗的样式通过[SsiDialogStyle]控制，开发者可以设置每一部分的间距、颜色、字体等一切和样式相关的配置
///
///有两种使用方式：
///1：系统的showDialog
///   无标题、单按钮
///   showDialog<void>(
///     context: context,
///     barrierDismissible: true,
///     builder: (BuildContext dialogContext) {
///       return SsiDialog(
///         messageText: "辅助内容信息辅助内容信息辅助内容信息辅助内容信息辅助内容信息",
///         actionsText: [],
///       );
///     },
///   );
///
///2：使用对话框管理器
///  无标题、单按钮
///  void _showStyle1Dialog(BuildContext context) {
///    SsiDialogManager.showSingleButtonDialog(context,
///        label: "知道了", message: "辅助内容信息辅助内容信息辅助内容信息辅助内容信息辅助内容信息", onTap: () {
///      SsiToast.show('知道了', context);
///    });
///  }
///

class SsiDialog extends AlertDialog {
  /// 标题控件
  final Widget? titleWidget;

  /// 内容控件
  final Widget? contentWidget;

  /// 警示文案部分的控件
  final Widget? warningWidget;

  /// 按钮部分控件
  final List<Widget>? actionsWidget;

  ///-----如果以上属性设置了，那么对话框中的相对应的部分 以他们为基准

  /// 标题文本
  final String? titleText;

  /// 内容文本
  final String? messageText;

  /// 警示文本
  final String? warningText;

  /// 底部按钮文案
  final List<String>? actionsText;

  /// 根据以上属性 生成对应的text控件

  /// 垂直分割线
  final VerticalDivider verticalDivider;

  /// 水平分割线
  final Divider divider;

  /// 对话框样式
  final SsiDialogStyle? dialogStyle;

  /// 底部按钮的点击监听回调
  final DialogIndexedActionClickCallback? indexedActionCallback;

  /// 是否展示头部icon
  final bool showIcon;

  /// 头部的icon
  final Widget? iconImage;

  /// dialog配置
  final SsiDialogConfig? themeData;

  /// 标题最大行数
  final int titleMaxLines;

  const SsiDialog({
    Key? key,
    this.showIcon = false,
    this.iconImage,
    this.titleText,
    this.messageText,
    this.titleWidget,
    this.contentWidget,
    this.warningText,
    this.warningWidget,
    this.actionsWidget,
    this.dialogStyle,
    this.divider = cDividerLine,
    this.verticalDivider = cVerticalDivider,
    this.actionsText,
    this.indexedActionCallback,
    this.themeData,
    this.titleMaxLines = cTitleMaxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SsiDialogConfig defaultConfig = _convertStyleToConfig();
    // defaultConfig = themeData ?? SsiDialogConfig();

    defaultConfig = SsiThemeConfigurator.instance
        .getConfig(configId: defaultConfig.configId)!
        .dialogConfig!
        .merge(defaultConfig);

    final List<Widget> children = <Widget>[];

    if (_isShowIcon()) {
      Widget generateIconWidget = _generateIconWidget(context, defaultConfig);
      children.add(generateIconWidget);
    }

    if (_isShowTitle()) {
      Widget generateTitleWidget = _generateTitleWidget(context, defaultConfig);
      children.add(generateTitleWidget);
    }

    if (_isShowContent()) {
      Widget generateContentWidget =
          _generateContentWidget(context, defaultConfig);
      children.add(generateContentWidget);
    }

    if (_isShowWarning()) {
      Widget generateWarningWidget =
          _generateWarningWidget(context, defaultConfig);
      children.add(generateWarningWidget);
    }

    children.add(Padding(
      padding: defaultConfig.dividerPadding ?? const EdgeInsets.only(top: 28),
      child: const SizedBox(
        height: 0,
        width: 0,
      ),
    ));

    if (!_isEmptyAction()) {
      children.add(divider);
      children.add(_generateActionsWidget(context, defaultConfig));
    }

    Widget dialogChild = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );

    return UnconstrainedBox(
        child: SizedBox(
            width: defaultConfig.dialogWidth,
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(
                      SsiDialogUtils.getDialogRadius(defaultConfig)))),
              child: dialogChild,
              color: defaultConfig.backgroundColor,
            )));
  }

  Widget _generateIconWidget(
      BuildContext context, SsiDialogConfig dialogConfig) {
    Widget _createWidget(Widget widget) {
      return Center(
        child: Padding(
          padding: dialogConfig.iconPadding ?? const EdgeInsets.only(top: 0),
          child: SizedBox(
            width: 36,
            height: 36,
            child: widget,
          ),
        ),
      );
    }

    if (iconImage != null) {
      return _createWidget(iconImage!);
    }
    if (showIcon) {
      return _createWidget(
          SsikitTools.getAssetImageWithBandColor("icons/icon_alter.png"));
    }

    return const SizedBox(
      width: 0,
      height: 0,
    );
  }

  /// 标题widget：以titleWidget为准，辅以title生成的Text。
  Widget _generateTitleWidget(
      BuildContext context, SsiDialogConfig dialogConfig) {
    if (titleWidget != null) {
      return DefaultTextStyle(
        textAlign: dialogConfig.titleTextAlign,
        style: SsiDialogUtils.getDialogTitleStyle(dialogConfig),
        child: titleWidget!,
      );
    }

    return Padding(
      padding: _configTitlePadding(dialogConfig),
      child: Text(
        titleText ?? "",
        maxLines: titleMaxLines,
        overflow: TextOverflow.ellipsis,
        style: SsiDialogUtils.getDialogTitleStyle(dialogConfig),
        textAlign: dialogConfig.titleTextAlign,
      ),
    );
  }

  /// 内容widget：以contentWidget为准，辅以message生成的Text
  Widget _generateContentWidget(
      BuildContext context, SsiDialogConfig dialogConfig) {
    if (contentWidget != null) {
      return Flexible(
        child: DefaultTextStyle(
          style: (dialogConfig.contentTextStyle)?.generateTextStyle() ??
              SsiTextStyle(fontSize: 14, color: const Color(0xFF666666))
                  .generateTextStyle(),
          child: contentWidget!,
        ),
      );
    }

    return Padding(
      padding: _configContentPadding(dialogConfig),
      child: Center(
        child: Text(
          messageText ?? "",
          style: (dialogConfig.contentTextStyle)?.generateTextStyle(),
          textAlign: dialogConfig.contentTextAlign,
        ),
      ),
    );
  }

  /// 警示widget：以warningWidget为准，辅以warning生成的Text
  Widget _generateWarningWidget(
      BuildContext context, SsiDialogConfig dialogConfig) {
    if (warningWidget != null) {
      return Flexible(
        child: DefaultTextStyle(
          style: (dialogConfig.warningTextStyle ?? SsiTextStyle())
              .generateTextStyle(),
          child: warningWidget!,
        ),
      );
    }

    return Padding(
      padding: _configWarningPadding(dialogConfig),
      child: Text(
        warningText ?? "",
        style: (dialogConfig.warningTextStyle ?? SsiTextStyle())
            .generateTextStyle(),
        textAlign: dialogConfig.warningTextAlign,
      ),
    );
  }

  /// 生成主按钮
  /// 单个button 左右有圆角
  /// 两个button 左button有左圆角&右直角 右button有右圆角&左直角
  /// 多个button 最后一个左右圆角  其他均直角
  Widget _generateMainWidget(Widget widget, Color background, ButtonType type,
      int index, SsiDialogConfig dialogConfig) {
    return Container(
      decoration: ShapeDecoration(
          color: background,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(type == ButtonType.Single ||
                          type == ButtonType.Left ||
                          (type == ButtonType.Multi &&
                              actionsText != null &&
                              index == actionsText!.length - 1)
                      ? SsiDialogUtils.getDialogRadius(dialogConfig)
                      : 0),
                  bottomRight: Radius.circular(type == ButtonType.Single ||
                          type == ButtonType.Right ||
                          (type == ButtonType.Multi &&
                              actionsText != null &&
                              index == actionsText!.length - 1)
                      ? SsiDialogUtils.getDialogRadius(dialogConfig)
                      : 0)))),
      constraints: BoxConstraints.tightFor(height: cBottomHeight),
      child: DefaultTextStyle(
        style: (dialogConfig.mainActionTextStyle ?? SsiTextStyle())
            .generateTextStyle(),
        child: Center(
          child: widget,
        ),
      ),
    );
  }

  /// 根据参数生成 灰色调的按钮
  /// 单个button 左右有圆角
  /// 两个button 左button有左圆角&右直角 右button有右圆角&左直角
  /// 多个button 最后一个左右圆角  其他均直角
  Widget _generateGreyWidget(Widget widget, Color background, ButtonType type,
      int index, SsiDialogConfig dialogConfig) {
    return Container(
      constraints: const BoxConstraints.tightFor(height: cBottomHeight),
      decoration: ShapeDecoration(
          color: background,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(type == ButtonType.Single ||
                          type == ButtonType.Left ||
                          (type == ButtonType.Multi &&
                              actionsText != null &&
                              index == actionsText!.length - 1)
                      ? SsiDialogUtils.getDialogRadius(dialogConfig)
                      : 0),
                  bottomRight: Radius.circular(type == ButtonType.Single ||
                          type == ButtonType.Right ||
                          (type == ButtonType.Multi &&
                              actionsText != null &&
                              index == actionsText!.length - 1)
                      ? SsiDialogUtils.getDialogRadius(dialogConfig)
                      : 0)))),
      child: DefaultTextStyle(
        style: (dialogConfig.assistActionsTextStyle ?? SsiTextStyle())
            .generateTextStyle(),
        child: Center(
          child: widget,
        ),
      ),
    );
  }

  Widget _generateActionsWidget(
      BuildContext context, SsiDialogConfig defaultConfig) {
    bool showTextActions = _isEmptyActionsWidget();
    int length =
        showTextActions ? actionsText?.length ?? 0 : actionsWidget?.length ?? 0;
    if (length == 1) {
      return showTextActions
          ? _mapTextToGesWidget(
              context,
              actionsText![0],
              0,
              true,
              defaultConfig,
              type: ButtonType.Single,
            )
          : actionsWidget![0];
    } else if (length == 2) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: showTextActions
                ? _mapTextToGesWidget(
                    context, actionsText![0], 0, false, defaultConfig,
                    type: ButtonType.Left)
                : actionsWidget![0],
          ),
          SizedBox(
            height: defaultConfig.bottomHeight,
            child: verticalDivider,
          ),
          Expanded(
            child: showTextActions
                ? _mapTextToGesWidget(
                    context, actionsText![1], 1, true, defaultConfig,
                    type: ButtonType.Right)
                : actionsWidget![1],
          )
        ],
      );
    } else {
      return SizedBox(
        height: 3 * (defaultConfig.bottomHeight ?? 0 + 1),
        width: double.maxFinite,
        child: ListView.separated(
            shrinkWrap: true,
            physics: length > 3 ? null : const NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              return showTextActions
                  ? _mapTextToGesWidget(
                      context, actionsText![i], i, true, defaultConfig,
                      type: ButtonType.Multi)
                  : actionsWidget![i];
            },
            separatorBuilder: (context, i) {
              return divider;
            },
            itemCount: length),
      );
    }
  }

  Widget _mapTextToGesWidget(BuildContext context, String label, int index,
      bool main, SsiDialogConfig dialogConfig,
      {ButtonType type = ButtonType.Single}) {
    Text text = Text(label);
    Widget ges = GestureDetector(
      child: main
          ? _generateMainWidget(
              text,
              dialogConfig.mainActionBackgroundColor ?? const Color(0xFFFFFFFF),
              type,
              index,
              dialogConfig)
          : _generateGreyWidget(
              text,
              dialogConfig.assistActionsBackgroundColor!,
              type,
              index,
              dialogConfig),
      onTap: () {
        if (indexedActionCallback != null) {
          //点击的监听
          indexedActionCallback!(index);
        } else {
          Navigator.pop(context);
        }
      },
    );
    return ges;
  }

  bool _isEmptyAction() {
    return _isEmptyActionsText() && _isEmptyActionsWidget();
  }

  bool _isShowIcon() {
    return (showIcon || iconImage != null);
  }

  bool _isShowTitle() {
    return (titleText != null || titleWidget != null);
  }

  bool _isShowContent() {
    return contentWidget != null || messageText != null;
  }

  bool _isShowWarning() {
    return warningWidget != null || warningText != null;
  }

  bool _isEmptyActionsText() {
    return actionsText == null || actionsText!.isEmpty;
  }

  bool _isEmptyActionsWidget() {
    return actionsWidget == null || actionsWidget!.isEmpty;
  }

  /// 将已有的SsiDialogStyle转换成SsiDialogConfig
  /// 当用户配置了最新的themeData则ljDialogStyle失效
  /// 当用户配置仅配置ljDialogStyle，则将ljDialogStyle转换成themeData
  SsiDialogConfig _convertStyleToConfig() {
    if (dialogStyle == null) {
      return themeData ?? SsiDialogConfig();
    }
    SsiDialogConfig defaultConfig = themeData ?? SsiDialogConfig();
    defaultConfig = defaultConfig.merge(SsiDialogConfig(
      mainActionTextStyle: SsiTextStyle.withStyle(dialogStyle?.mainTextStyle),
      mainActionBackgroundColor: dialogStyle?.mainBackgroundColor,
      assistActionsTextStyle:
          SsiTextStyle.withStyle(dialogStyle?.greyActionsTextStyle),
      assistActionsBackgroundColor: dialogStyle?.greyActionsBackgroundColor,
      radius: dialogStyle?.radius,
      iconPadding: dialogStyle?.iconPadding,
      titlePaddingSm: dialogStyle?.titlePadding,
      titlePaddingLg: dialogStyle?.titlePadding,
      titleTextAlign: dialogStyle?.titleTextAlign,
      titleTextStyle: SsiTextStyle.withStyle(dialogStyle?.titleTextStyle),
      contentPaddingSm: dialogStyle?.contentPadding,
      contentPaddingLg: dialogStyle?.contentPadding,
      contentTextAlign: dialogStyle?.contentTextAlign,
      contentTextStyle: SsiTextStyle.withStyle(dialogStyle?.contentTextStyle),
      warningPaddingSm: dialogStyle?.warningPadding,
      warningPaddingLg: dialogStyle?.warningPadding,
      warningTextAlign: dialogStyle?.warningTextAlign,
      warningTextStyle: SsiTextStyle.withStyle(dialogStyle?.warningTextStyle),
      bottomHeight: dialogStyle?.bottomHeight,
      backgroundColor: dialogStyle?.backgroundColor,
    ));
    return defaultConfig;
  }

  /// 主题配置的标题间距
  EdgeInsetsGeometry _configTitlePadding(SsiDialogConfig dialogConfig) {
    return _isShowIcon()
        ? dialogConfig.titlePaddingSm!
        : dialogConfig.titlePaddingLg!;
  }

  /// 主题配置的内容间距
  EdgeInsetsGeometry _configContentPadding(SsiDialogConfig dialogConfig) {
    return (_isShowIcon() || _isShowTitle())
        ? dialogConfig.contentPaddingSm!
        : dialogConfig.contentPaddingLg!;
  }

  /// 主题配置的警告间距
  EdgeInsetsGeometry _configWarningPadding(SsiDialogConfig dialogConfig) {
    return (_isShowIcon() || _isShowTitle() || _isShowContent())
        ? dialogConfig.warningPaddingSm!
        : dialogConfig.warningPaddingLg!;
  }
}

/// 是对话框显示的管理类。
/// 根据底部按钮的数量分为：单个按钮对话框、两个按钮对话框 和 不定按钮对话框
///
/// 通用属性：
/// showIcon 是否展示 头部Icon，会展示默认的 对号图片
/// iconWidget 头部icon的图片，如果设置了这个属性 即使showIcon为false也会展示 设置的图片
///
/// title 是展示的标题文案
/// titleWidget 展示的标题widget，如果设置了widget 则会以widget为准
///
/// message 中间的辅助信息文案
/// messageWidget 展示中间辅助信息的widget
///
/// warning 警示文案
/// warningWidget 展示警示文案的widget
///
/// dismiss 点击按钮后是否 消失弹窗
///
/// dialogStyle 对话框的样式：间距、字体、阴影等
///
/// barrierDismissible 点击四周的黑色遮罩 是否关闭弹窗
///
/// titleMaxLines 标题的最大行数
///
class SsiDialogManager {
  ///展示底部只有一个按钮的对话框 对话框的点击回调是onTap
  ///label 底部按钮的文案
  ///labelWidget  自定义底部按钮的显示
  static void showSingleButtonDialog(
    BuildContext context, {
    required String label,
    bool showIcon = false,
    Image? iconWidget,
    String? title,
    Widget? titleWidget,
    String? message,
    Widget? messageWidget,
    String? warning,
    Widget? warningWidget,
    Widget? labelWidget,
    SsiDialogStyle? dialogStyle,
    GestureTapCallback? onTap,
    bool barrierDismissible = true,
    int titleMaxLines = cTitleMaxLines,
    SsiDialogConfig? themeData,
  }) {
    List<Widget> actionsWidget = [];

    if (labelWidget != null) {
      actionsWidget.add(labelWidget);
    }
    showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext dialogContext) {
        return SsiDialog(
          iconImage: iconWidget,
          showIcon: showIcon,
          titleText: title,
          titleWidget: titleWidget,
          messageText: message,
          contentWidget: messageWidget,
          warningText: warning,
          warningWidget: warningWidget,
          actionsText: [label],
          dialogStyle: dialogStyle,
          actionsWidget: actionsWidget,
          titleMaxLines: titleMaxLines,
          themeData: themeData,
          indexedActionCallback: (index) {
            if (index == 0) {
              if (onTap != null) {
                onTap();
              }
            }
          },
        );
      },
    );
  }

  /// 展示底部有两个按钮的弹窗 左侧是cancel 右侧是confirm
  /// cancel 左侧显示的文案
  /// confirm 右侧显示的文案
  /// cancelWidget 自定义显示的左侧
  /// conformWidget 自定义显示的右侧
  static void showConfirmDialog(
    BuildContext context, {
    required String cancel,
    required String confirm,
    bool showIcon = false,
    Image? iconWidget,
    String? title,
    Widget? titleWidget,
    String? message,
    Widget? messageWidget,
    String? warning,
    Widget? warningWidget,
    Widget? cancelWidget,
    Widget? conformWidget,
    SsiDialogStyle? dialogStyle,
    GestureTapCallback? onCancel,
    GestureTapCallback? onConfirm,
    bool barrierDismissible = true,
    int titleMaxLines = cTitleMaxLines,
    SsiDialogConfig? themeData,
  }) {
    List<Widget> actionsWidget = [];

    if (cancelWidget != null) {
      actionsWidget.add(cancelWidget);
    }
    if (conformWidget != null) {
      actionsWidget.add(conformWidget);
    }
    showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext dialogContext) {
        return SsiDialog(
          iconImage: iconWidget,
          showIcon: showIcon,
          titleText: title,
          titleWidget: titleWidget,
          messageText: message,
          contentWidget: messageWidget,
          warningWidget: warningWidget,
          warningText: warning,
          themeData: themeData,
          titleMaxLines: titleMaxLines,
          dialogStyle: dialogStyle,
          actionsText: [cancel, confirm],
          actionsWidget: actionsWidget,
          indexedActionCallback: (index) {
            if (index == 0) {
              if (onCancel != null) {
                onCancel();
              }
            }
            if (index == 1) {
              if (onConfirm != null) {
                onConfirm();
              }
            }
          },
        );
      },
    );
  }

  ///展示底部按钮为多个的dialog 如果设置的是文字按钮那么，每个按钮的点击通过indexedActionClickCallback处理
  ///如果底部按钮的数量小于等于2 ，会以横排展示，否则会议竖排展示
  ///如果数量超过了三个 会滑动展示
  static void showMoreButtonDialog(
    BuildContext context, {
    required List<String> actions,
    bool showIcon = false,
    Image? iconWidget,
    String? title,
    Widget? titleWidget,
    String? message,
    Widget? messageWidget,
    String? warning,
    Widget? warningWidget,
    List<Widget>? actionsWidget,
    bool barrierDismissible = true,
    SsiDialogStyle? dialogStyle,
    int titleMaxLines = cTitleMaxLines,
    SsiDialogConfig? themeData,
    DialogIndexedActionClickCallback? indexedActionClickCallback,
  }) {
    showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext dialogContext) {
        return SsiDialog(
            iconImage: iconWidget,
            showIcon: showIcon,
            titleText: title,
            titleWidget: titleWidget,
            messageText: message,
            contentWidget: messageWidget,
            warningWidget: warningWidget,
            warningText: warning,
            dialogStyle: dialogStyle,
            actionsText: actions,
            actionsWidget: actionsWidget,
            themeData: themeData,
            titleMaxLines: titleMaxLines,
            indexedActionCallback: indexedActionClickCallback);
      },
    );
  }
}
