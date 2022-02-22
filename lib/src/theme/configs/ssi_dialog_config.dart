import 'package:flutter/material.dart';
import 'package:flutter_ssikit/flutter_ssikit.dart';

///  描述: Dialog 弹框主配置类

class SsiDialogConfig extends SsiBaseConfig {
  /// Dialog 宽度
  /// default 300
  double? dialogWidth;

  /// Dialog 四周圆角
  /// default 8.0  use  [SsiCommonConfig.radiusLg]
  double? radius;

  /// Dialog icon 距离顶部的边距 仅有顶部间距
  /// default EdgeInsets.only(top: [SsiCommonConfig.vSpacingXxl])
  EdgeInsets? iconPadding;

  /// title 当顶部  有  icon时四周间距,无底部间距
  /// default EdgeInsets.only(top: 12, left: [SsiCommonConfig.hSpacingXxl], right: [SsiCommonConfig.hSpacingXxl])
  EdgeInsets? titlePaddingSm;

  /// title 当顶部  无  icon时四周间距,无底部间距
  /// default EdgeInsets.only(top: 28, left: [SsiCommonConfig.hSpacingXxl], right: [SsiCommonConfig.hSpacingXxl])
  EdgeInsets? titlePaddingLg;

  /// title 标题样式
  /// default SsiTextStyle(fontWeight: FontWeight.w600, fontSize: [ SsiCommonConfig.fontSizeHead], color: [SsiCommonConfig.colorTextBase])
  SsiTextStyle? titleTextStyle;

  /// 标题的文字对齐
  /// default TextAlign.center
  TextAlign? titleTextAlign;

  /// content 当顶部  有  title或者icon时四周间距，无底部间距
  /// default EdgeInsets.only(top: 8, lecontentPaddingSmft: [SsiCommonConfig.hSpacingXl], right: [SsiCommonConfig.hSpacingXl])
  EdgeInsets? contentPaddingSm;

  /// content 当顶部  无  title或者icon时四周间距，无底部间距
  /// default EdgeInsets.only(top: 28, left: [SsiCommonConfig.hSpacingXl], right: [SsiCommonConfig.hSpacingXl])
  EdgeInsets? contentPaddingLg;

  /// message 内容样式
  /// default SsiTextStyle(fontSize: [SsiCommonConfig.fontSizeBase], color: [SsiCommonConfig.colorTextImportant])
  SsiTextStyle? contentTextStyle;

  /// 内容文字的对齐
  /// default TextAlign.center
  TextAlign? contentTextAlign;

  /// warning 当顶部 有 title/icon/content时四周边距，无底部间距
  /// default EdgeInsets.only(top: 6, left: [SsiCommonConfig.hSpacingXl], right: [SsiCommonConfig.hSpacingXl])
  EdgeInsets? warningPaddingSm;

  /// warning 当顶部 无 title/icon/content时四周边距，无底部间距
  /// default EdgeInsets.only(top: 28, left: [SsiCommonConfig.hSpacingXl], right: [SsiCommonConfig.hSpacingXl])
  EdgeInsets? warningPaddingLg;

  /// 警告样式
  /// default SsiTextStyle(fontSize: [SsiCommonConfig.fontSizeBase], color: [SsiCommonConfig.brandError])
  SsiTextStyle? warningTextStyle;

  /// 警示文案文字的对齐
  /// default TextAlign.center
  TextAlign? warningTextAlign;

  /// action 顶部 divider 的上方边距
  /// default EdgeInsets.only(top: 28)
  EdgeInsets? dividerPadding;

  /// 主色调按钮样式
  /// default SsiTextStyle(color: [SsiCommonConfig.brandPrimary], fontWeight: FontWeight.w600, fontSize: [SsiCommonConfig.fontSizeSubHead])
  SsiTextStyle? mainActionTextStyle;

  /// 主色调按钮的背景
  /// default [SsiCommonConfig.fillBase]
  Color? mainActionBackgroundColor;

  /// 其他按钮的样式(超2个时按钮样式)
  /// SsiTextStyle(color: [SsiCommonConfig.colorTextBase], fontWeight: FontWeight.w600,fontSize: [SsiCommonConfig.fontSizeSubHead])
  SsiTextStyle? assistActionsTextStyle;

  /// 其他按钮的背景
  /// default [SsiCommonConfig.fillBase]
  Color? assistActionsBackgroundColor;

  /// 底部按钮高度
  /// default 44.0
  double? bottomHeight;

  /// Dialog背景
  /// default [SsiCommonConfig.fillBase]
  Color? backgroundColor;

  SsiDialogConfig(
      {this.dialogWidth,
      this.radius,
      this.iconPadding,
      this.titlePaddingSm,
      this.titlePaddingLg,
      this.titleTextStyle,
      this.titleTextAlign,
      this.contentPaddingSm,
      this.contentPaddingLg,
      this.contentTextStyle,
      this.contentTextAlign,
      this.warningPaddingSm,
      this.warningPaddingLg,
      this.warningTextStyle,
      this.warningTextAlign,
      this.dividerPadding,
      this.mainActionTextStyle,
      this.assistActionsTextStyle,
      this.mainActionBackgroundColor,
      this.assistActionsBackgroundColor,
      this.bottomHeight,
      this.backgroundColor,
      String configId = SsiThemeConfigurator.GLOBAL_CONFIG_ID})
      : super(configId: configId);

  /// 按优先级，打平 【Bruno 内置配置】 < 【用户全局的默认配置】 < 【用户特殊配置】 < 【临时组件配置】
  ///
  /// 举例：
  /// ① 尝试获取最近的配置 [topRadius] 若配不为 null，直接使用该配置.
  /// ② [topRadius] 若为 null，尝试使用 全局配置中的配置 dialogConfig.
  /// ③ 如果全局配置中的配置同样为 null 则根据 [configId] 取出全局配置。
  /// ④ 如果没有配置 [configId] 的全局配置，则使用 Bruno 默认的配置
  @override
  void initThemeConfig(String configId,
      {SsiCommonConfig? currentLevelCommonConfig}) {
    super.initThemeConfig(configId,
        currentLevelCommonConfig: currentLevelCommonConfig);

    /// 用户全局组件配置
    SsiDialogConfig? dialogConfig = SsiThemeConfigurator.instance
        .getConfig(configId: configId)
        ?.dialogConfig;

    dialogWidth ??= dialogConfig?.dialogWidth;

    radius ??= commonConfig?.radiusLg;

    titlePaddingSm ??= EdgeInsets.only(
        left: commonConfig?.hSpacingXxl ?? 42,
        right: commonConfig?.hSpacingXxl ?? 42,
        top: dialogConfig?.titlePaddingSm?.top ?? 0,
        bottom: dialogConfig?.titlePaddingSm?.bottom ?? 0);

    titlePaddingLg ??= EdgeInsets.only(
        left: commonConfig?.hSpacingXxl ?? 42,
        right: commonConfig?.hSpacingXxl ?? 42,
        top: dialogConfig?.titlePaddingLg?.top ?? 0,
        bottom: dialogConfig?.titlePaddingLg?.bottom ?? 0);

    iconPadding ??= EdgeInsets.only(
        left: dialogConfig?.iconPadding?.left ?? 0,
        top: commonConfig?.vSpacingXxl ?? 28,
        right: dialogConfig?.iconPadding?.right ?? 0,
        bottom: dialogConfig?.iconPadding?.bottom ?? 0);

    titleTextStyle = dialogConfig?.titleTextStyle?.merge(SsiTextStyle(
            color: commonConfig?.colorTextBase ?? const Color(0xFF222222),
            fontSize: commonConfig?.fontSizeHead ?? 18)
        .merge(titleTextStyle));

    contentTextStyle = dialogConfig?.contentTextStyle?.merge(SsiTextStyle(
            color: commonConfig?.colorTextImportant ?? const Color(0xFF666666),
            fontSize: commonConfig?.fontSizeBase ?? 14)
        .merge(contentTextStyle));

    warningTextStyle = dialogConfig?.warningTextStyle?.merge(SsiTextStyle(
            color: commonConfig?.brandError,
            fontSize: commonConfig?.fontSizeBase)
        .merge(warningTextStyle));

    mainActionTextStyle = dialogConfig?.mainActionTextStyle?.merge(SsiTextStyle(
            color: commonConfig?.brandPrimary,
            fontSize: commonConfig?.fontSizeSubHead)
        .merge(mainActionTextStyle));

    assistActionsTextStyle = dialogConfig?.assistActionsTextStyle?.merge(
        SsiTextStyle(
                color: commonConfig?.colorTextBase,
                fontSize: commonConfig?.fontSizeSubHead)
            .merge(assistActionsTextStyle));

    contentPaddingSm ??= EdgeInsets.only(
        left: commonConfig?.hSpacingXl ?? 24,
        right: commonConfig?.hSpacingXl ?? 24,
        top: dialogConfig?.contentPaddingSm?.top ?? 0,
        bottom: dialogConfig?.contentPaddingSm?.bottom ?? 0);

    contentPaddingLg ??= EdgeInsets.only(
        left: commonConfig?.hSpacingXl ?? 24,
        right: commonConfig?.hSpacingXl ?? 24,
        top: dialogConfig?.contentPaddingLg?.top ?? 0,
        bottom: dialogConfig?.contentPaddingLg?.bottom ?? 0);

    warningPaddingSm ??= EdgeInsets.only(
        left: commonConfig?.hSpacingXl ?? 24,
        right: commonConfig?.hSpacingXl ?? 24,
        top: dialogConfig?.warningPaddingSm?.top ?? 0,
        bottom: dialogConfig?.warningPaddingSm?.bottom ?? 0);

    warningPaddingLg ??= EdgeInsets.only(
        left: commonConfig?.hSpacingXl ?? 24,
        right: commonConfig?.hSpacingXl ?? 24,
        top: dialogConfig?.warningPaddingLg?.top ?? 0,
        bottom: dialogConfig?.warningPaddingLg?.bottom ?? 0);

    titleTextAlign ??= dialogConfig?.titleTextAlign;

    contentTextAlign ??= dialogConfig?.contentTextAlign;

    warningTextAlign ??= dialogConfig?.warningTextAlign;

    mainActionBackgroundColor ??= commonConfig?.fillBase;

    assistActionsBackgroundColor ??= commonConfig?.fillBase;

    bottomHeight ??= dialogConfig?.bottomHeight;

    dividerPadding ??= dialogConfig?.dividerPadding;

    backgroundColor ??= commonConfig?.fillBase;
  }

  SsiDialogConfig copyWith(
      {double? dialogWidth,
      double? radius,
      EdgeInsets? iconPadding,
      EdgeInsets? titlePaddingSm,
      EdgeInsets? titlePaddingLg,
      SsiTextStyle? titleTextStyle,
      TextAlign? titleTextAlign,
      EdgeInsets? contentPaddingSm,
      EdgeInsets? contentPaddingLg,
      SsiTextStyle? contentTextStyle,
      TextAlign? contentTextAlign,
      EdgeInsets? warningPaddingSm,
      EdgeInsets? warningPaddingLg,
      SsiTextStyle? warningTextStyle,
      TextAlign? warningTextAlign,
      EdgeInsets? dividerPadding,
      SsiTextStyle? mainActionTextStyle,
      SsiTextStyle? assistActionsTextStyle,
      Color? mainActionBackgroundColor,
      Color? assistActionsBackgroundColor,
      double? bottomHeight,
      Color? backgroundColor}) {
    return SsiDialogConfig(
        dialogWidth: dialogWidth ?? this.dialogWidth,
        radius: radius ?? this.radius,
        iconPadding: iconPadding ?? this.iconPadding,
        titlePaddingSm: titlePaddingSm ?? this.titlePaddingSm,
        titlePaddingLg: titlePaddingLg ?? this.titlePaddingLg,
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        titleTextAlign: titleTextAlign ?? this.titleTextAlign,
        contentPaddingSm: contentPaddingSm ?? this.contentPaddingSm,
        contentPaddingLg: contentPaddingLg ?? this.contentPaddingLg,
        contentTextStyle: contentTextStyle ?? this.contentTextStyle,
        contentTextAlign: contentTextAlign ?? this.contentTextAlign,
        warningPaddingSm: warningPaddingSm ?? this.warningPaddingSm,
        warningPaddingLg: warningPaddingLg ?? this.warningPaddingLg,
        warningTextStyle: warningTextStyle ?? this.warningTextStyle,
        warningTextAlign: warningTextAlign ?? this.warningTextAlign,
        dividerPadding: dividerPadding ?? this.dividerPadding,
        mainActionTextStyle: mainActionTextStyle ?? this.mainActionTextStyle,
        assistActionsTextStyle:
            assistActionsTextStyle ?? this.assistActionsTextStyle,
        mainActionBackgroundColor:
            mainActionBackgroundColor ?? this.mainActionBackgroundColor,
        assistActionsBackgroundColor:
            assistActionsBackgroundColor ?? this.assistActionsBackgroundColor,
        bottomHeight: bottomHeight ?? this.bottomHeight,
        backgroundColor: backgroundColor ?? this.backgroundColor);
  }

  SsiDialogConfig merge(SsiDialogConfig other) {
    if (other == null) return this;
    return copyWith(
        dialogWidth: other.dialogWidth,
        radius: other.radius,
        iconPadding: other.iconPadding,
        titlePaddingSm: other.titlePaddingSm,
        titlePaddingLg: other.titlePaddingLg,
        titleTextStyle:
            titleTextStyle?.merge(other.titleTextStyle) ?? other.titleTextStyle,
        titleTextAlign: other.titleTextAlign,
        contentPaddingSm: other.contentPaddingSm,
        contentPaddingLg: other.contentPaddingLg,
        contentTextStyle: contentTextStyle?.merge(other.contentTextStyle) ??
            other.contentTextStyle,
        contentTextAlign: other.contentTextAlign,
        warningPaddingSm: other.warningPaddingSm,
        warningPaddingLg: other.warningPaddingLg,
        warningTextStyle: warningTextStyle?.merge(other.warningTextStyle) ??
            other.warningTextStyle,
        warningTextAlign: other.warningTextAlign,
        dividerPadding: other.dividerPadding,
        mainActionTextStyle:
            mainActionTextStyle?.merge(other.mainActionTextStyle) ??
                other.mainActionTextStyle,
        assistActionsTextStyle:
            assistActionsTextStyle?.merge(other.assistActionsTextStyle) ??
                other.assistActionsTextStyle,
        mainActionBackgroundColor: other.mainActionBackgroundColor,
        assistActionsBackgroundColor: other.assistActionsBackgroundColor,
        bottomHeight: other.bottomHeight,
        backgroundColor: other.backgroundColor);
  }
}
