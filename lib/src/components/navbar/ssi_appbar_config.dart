import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ssikit/src/constants/ssi_asset_constants.dart';
import 'package:flutter_ssikit/src/constants/ssi_strings_constants.dart';
import 'package:flutter_ssikit/src/theme/ssi_theme.dart';

import 'ssi_appbar_theme.dart';

typedef SsiWidgetBuilder = Widget Function();

/// Appbar主题配置
class SsiAppBarConfig {
  

  static SsiAppBarConfig defaultAppBarConfig() {
    return SsiAppBarConfig(
      backgroundColor: Colors.white,
      leadIconBuilder: () => Image.asset(
        SsiAsset.ICON_BACK_BLACK,
        package: SsiStrings.flutterPackageName,
        width: SsiAppBarTheme.iconSize,
        height: SsiAppBarTheme.iconSize,
        fit: BoxFit.fitHeight,
      )
    );
  }

  /// SsiAppBar 主题配置，遵循外部主题配置，默认配置[defaultAppBarConfig]
  SsiAppBarConfig(
      {this.backgroundColor,
      this.appBarHeight = SsiAppBarTheme.appBarHeight,
      this.leadIconBuilder,
      this.titleStyle,
      this.actionsStyle,
      this.titleMaxLength = SsiAppBarTheme.maxLength,
      this.leftAndRightPadding = SsiAppBarTheme.leftAndRightPadding,
      this.itemSpacing = SsiAppBarTheme.iconMargin,
      this.titlePadding,
      this.iconSize = SsiAppBarTheme.iconSize,
      this.flexibleSpace,
      this.systemUiOverlayStyle = SystemUiOverlayStyle.light}) {
        
    titleStyle ??= SsiTextStyle(
        fontSize: SsiAppBarTheme.titleFontSize,
        fontWeight: FontWeight.w600,
        color: SsiAppBarTheme.lightTextColor);
    actionsStyle ??= SsiTextStyle(
        color: SsiAppBarTheme.lightTextColor,
        fontSize: SsiAppBarTheme.actionFontSize,
        fontWeight: FontWeight.w600);
  }

  SsiAppBarConfig.dark({
    this.backgroundColor,
    this.appBarHeight = SsiAppBarTheme.appBarHeight,
    this.leadIconBuilder,
    this.titleStyle,
    this.actionsStyle,
    this.titleMaxLength = SsiAppBarTheme.maxLength,
    this.leftAndRightPadding = SsiAppBarTheme.leftAndRightPadding,
    this.itemSpacing = SsiAppBarTheme.iconMargin,
    this.titlePadding,
    this.iconSize = SsiAppBarTheme.iconSize,
    this.flexibleSpace,
    this.systemUiOverlayStyle = SystemUiOverlayStyle.light,
  }) {
    systemUiOverlayStyle = SystemUiOverlayStyle.light;
    backgroundColor = const Color(0xff2E313B);
    leadIconBuilder = () => Image.asset(
          SsiAsset.ICON_BACK_WHITE,
          package: SsiStrings.flutterPackageName,
          width: SsiAppBarTheme.iconSize,
          height: SsiAppBarTheme.iconSize,
          fit: BoxFit.fitHeight,
        );
    titleStyle = SsiTextStyle(
        fontSize: SsiAppBarTheme.titleFontSize,
        fontWeight: FontWeight.w600,
        color: SsiAppBarTheme.darkTextColor);
    actionsStyle = SsiTextStyle(
        color: SsiAppBarTheme.darkTextColor,
        fontSize: SsiAppBarTheme.actionFontSize,
        fontWeight: FontWeight.w600);
  }

  SsiAppBarConfig.light({
    this.backgroundColor,
    this.appBarHeight = SsiAppBarTheme.appBarHeight,
    this.leadIconBuilder,
    this.titleStyle,
    this.actionsStyle,
    this.titleMaxLength = SsiAppBarTheme.maxLength,
    this.leftAndRightPadding = SsiAppBarTheme.leftAndRightPadding,
    this.itemSpacing = SsiAppBarTheme.iconMargin,
    this.titlePadding,
    this.iconSize = SsiAppBarTheme.iconSize,
    this.flexibleSpace,
    this.systemUiOverlayStyle = SystemUiOverlayStyle.dark,
  }) {
    systemUiOverlayStyle = SystemUiOverlayStyle.dark;
    backgroundColor = Colors.white;
    leadIconBuilder = () => Image.asset(
          SsiAsset.ICON_BACK_BLACK,
          package: SsiStrings.flutterPackageName,
          width: SsiAppBarTheme.iconSize,
          height: SsiAppBarTheme.iconSize,
          fit: BoxFit.fitHeight,
        );
    titleStyle = SsiTextStyle(
        fontSize: SsiAppBarTheme.titleFontSize,
        fontWeight: FontWeight.w600,
        color: SsiAppBarTheme.lightTextColor);
    actionsStyle = SsiTextStyle(
        color: SsiAppBarTheme.lightTextColor,
        fontSize: SsiAppBarTheme.actionFontSize,
        fontWeight: FontWeight.w600);
  }

  /// AppBar的背景色
  Color? backgroundColor;

  /// AppBar的高度
  double appBarHeight;

  /// 返回按钮的child widget，一般为Image
  SsiWidgetBuilder? leadIconBuilder;

  /// 标题样式，仅当直接title设置为String生效，[注意]：`fontSize`必须传大小，否则报错
  SsiTextStyle? titleStyle;

  /// 右侧文字按钮样式，仅当直接actions里面元素为SsiTextAction类型生效[注意]：`fontSize`必须传大小，否则报错
  /// default value is TextStyle(color: AppBarBrightness(brightness).textColor,fontSize: SsiAppBarTheme.actionFontSize,fontWeight: FontWeight.w600)
  SsiTextStyle? actionsStyle;

  /// AppBar title的最大字符数 8
  int titleMaxLength;

  /// 左右边距
  double leftAndRightPadding;

  /// 元素间间距
  double itemSpacing;

  /// title的padding
  EdgeInsets? titlePadding;

  /// leadIcon 宽高，需要相同
  /// default value is 20
  double iconSize;

  ///[AppBar]中flexibleSpace
  Widget? flexibleSpace;

  /// statusBar 样式
  /// default value is SystemUiOverlayStyle.dark
  SystemUiOverlayStyle systemUiOverlayStyle;

  SsiAppBarConfig copyWith({
    Color? backgroundColor,
    double appBarHeight = SsiAppBarTheme.appBarHeight,
    SsiWidgetBuilder? leadIconBuilder,
    SsiTextStyle? titleStyle,
    SsiTextStyle? actionsStyle,
    int titleMaxLength = SsiAppBarTheme.maxLength,
    double leftAndRightPadding = SsiAppBarTheme.leftAndRightPadding,
    double itemSpacing = SsiAppBarTheme.iconMargin,
    EdgeInsets? titlePading,
    double iconSize = SsiAppBarTheme.iconSize,
    Widget? flexibleSpace,
    SystemUiOverlayStyle? systemUiOverlayStyle,
  }) {
    return SsiAppBarConfig(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        appBarHeight: appBarHeight,
        leadIconBuilder: leadIconBuilder ?? this.leadIconBuilder,
        titleStyle: titleStyle ?? this.titleStyle,
        actionsStyle: actionsStyle ?? this.actionsStyle,
        titleMaxLength: titleMaxLength,
        leftAndRightPadding: leftAndRightPadding,
        itemSpacing: itemSpacing,
        titlePadding: titlePading,
        iconSize: iconSize,
        flexibleSpace: flexibleSpace,
        systemUiOverlayStyle:
            systemUiOverlayStyle ?? this.systemUiOverlayStyle);
  }

  SsiAppBarConfig merge(SsiAppBarConfig? other) {
    if (other == null) return this;
    return copyWith(
        backgroundColor: other.backgroundColor,
        appBarHeight: other.appBarHeight,
        leadIconBuilder: other.leadIconBuilder,
        titleStyle: titleStyle?.merge(other.titleStyle) ?? other.titleStyle,
        actionsStyle:
            actionsStyle?.merge(other.actionsStyle) ?? other.actionsStyle,
        titleMaxLength: other.titleMaxLength,
        leftAndRightPadding: other.leftAndRightPadding,
        itemSpacing: other.itemSpacing,
        titlePading: other.titlePadding,
        iconSize: other.iconSize,
        flexibleSpace: other.flexibleSpace,
        systemUiOverlayStyle: other.systemUiOverlayStyle);
  }
}
