import '../base/ssi_base_config.dart';
import '../base/ssi_text_style.dart';
import '../ssi_theme_configurator.dart';
import 'ssi_common_config.dart';
import 'package:flutter/material.dart';
import '../../components/picker/base/ssi_picker_constants.dart';

/// 选择器配置
class SsiPickerConfig extends SsiBaseConfig {
  
  ///遵循外部主题配置，Bruno默认配置[SsiDefaultConfigUtils.defaultPickerConfig]
  SsiPickerConfig(
      {this.backgroundColor,
      this.cancelTextStyle,
      this.confirmTextStyle,
      this.titleTextStyle,
      this.pickerHeight = PICKER_HEIGHT,
      this.titleHeight = PICKER_TITLE_HEIGHT,
      this.itemHeight = PICKER_ITEM_HEIGHT,
      this.itemTextStyle,
      this.itemTextSelectedStyle,
      this.dividerColor,
      this.cornerRadius = 8,
      String configId = SsiThemeConfigurator.GLOBAL_CONFIG_ID})
      : super(configId: configId);

  /// DatePicker's background color. value is [PICKER_BACKGROUND_COLOR]
  Color? backgroundColor;

  /// cancel text style
  /// Default style is TextStyle(color:[SsiCommonConfig.colorTextBase],fontSize:[SsiCommonConfig.fontSizeSubHead]).
  SsiTextStyle? cancelTextStyle;

  /// confirm text style
  /// Default style is TextStyle(color:[SsiCommonConfig.brandPrimary],fontSize:[SsiCommonConfig.fontSizeSubHead]).
  SsiTextStyle? confirmTextStyle;

  /// title style
  /// Default style is TextStyle(color:[SsiCommonConfig.colorTextBase],fontSize:[SsiCommonConfig.fontSizeSubHead],fontWidget:FontWeight.w600).
  SsiTextStyle? titleTextStyle;

  /// The value of DatePicker's height.
  /// default value is [PICKER_HEIGHT]
  double pickerHeight;

  /// The value of DatePicker's title height.
  /// default value is [PICKER_TITLE_HEIGHT]
  double titleHeight;

  /// The value of DatePicker's column height.
  /// default value is [PICKER_ITEM_HEIGHT]
  double itemHeight;

  /// The value of DatePicker's column [TextStyle].
  /// Default style is TextStyle(color:[SsiCommonConfig.colorTextBase],fontSize:[SsiCommonConfig.fontSizeHead]).
  SsiTextStyle? itemTextStyle;

  /// The value of DatePicker's column selected [TextStyle].
  /// Default style is TextStyle(color:[SsiCommonConfig.brandPrimary],fontSize:[SsiCommonConfig.fontSizeHead],fontWidget:FontWeight.w600).
  SsiTextStyle? itemTextSelectedStyle;

  Color? dividerColor;
  double cornerRadius;

  @override
  void initThemeConfig(String configId,
      {SsiCommonConfig? currentLevelCommonConfig}) {
    super.initThemeConfig(configId,
        currentLevelCommonConfig: currentLevelCommonConfig);

    /// 用户全局组件配置
    SsiPickerConfig? pickerConfig = SsiThemeConfigurator.instance
        .getConfig(configId: configId)
        ?.pickerConfig;

    backgroundColor ??= pickerConfig?.backgroundColor;
    pickerHeight = pickerConfig?.pickerHeight ?? PICKER_HEIGHT;
    titleHeight = pickerConfig?.titleHeight ?? PICKER_TITLE_HEIGHT;
    itemHeight = pickerConfig?.itemHeight ?? PICKER_ITEM_HEIGHT;
    dividerColor ??= pickerConfig?.dividerColor;
    cornerRadius = pickerConfig?.cornerRadius ?? 8;

    titleTextStyle = pickerConfig?.titleTextStyle?.merge(SsiTextStyle(
            color: commonConfig?.colorTextBase,
            fontSize: commonConfig?.fontSizeSubHead)
        .merge(titleTextStyle));

    cancelTextStyle = pickerConfig?.cancelTextStyle
        ?.merge(SsiTextStyle(
            color: commonConfig?.colorTextBase,
            fontSize: commonConfig?.fontSizeSubHead))
        .merge(cancelTextStyle);

    confirmTextStyle = pickerConfig?.confirmTextStyle?.merge(SsiTextStyle(
            color: commonConfig?.brandPrimary,
            fontSize: commonConfig?.fontSizeSubHead)
        .merge(confirmTextStyle));

    itemTextStyle = pickerConfig?.itemTextStyle?.merge(SsiTextStyle(
            color: commonConfig?.colorTextBase,
            fontSize: commonConfig?.fontSizeHead)
        .merge(itemTextStyle));

    itemTextSelectedStyle = pickerConfig?.itemTextSelectedStyle?.merge(
        SsiTextStyle(
                color: commonConfig?.brandPrimary,
                fontSize: commonConfig?.fontSizeHead)
            .merge(itemTextSelectedStyle));
  }

  SsiPickerConfig copyWith(
      {Color? backgroundColor,
      SsiTextStyle? cancelTextStyle,
      SsiTextStyle? confirmTextStyle,
      SsiTextStyle? titleTextStyle,
      double pickerHeight = PICKER_HEIGHT,
      double titleHeight = PICKER_TITLE_HEIGHT,
      double itemHeight = PICKER_ITEM_HEIGHT,
      SsiTextStyle? itemTextStyle,
      SsiTextStyle? itemTextSelectedStyle,
      Color? dividerColor,
      double cornerRadius = 8}) {
    return SsiPickerConfig(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      cancelTextStyle: cancelTextStyle ?? this.cancelTextStyle,
      confirmTextStyle: confirmTextStyle ?? this.confirmTextStyle,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      pickerHeight: pickerHeight,
      titleHeight: titleHeight,
      itemHeight: itemHeight,
      itemTextStyle: itemTextStyle ?? this.itemTextStyle,
      itemTextSelectedStyle:
          itemTextSelectedStyle ?? this.itemTextSelectedStyle,
      dividerColor: dividerColor ?? this.dividerColor,
      cornerRadius: cornerRadius,
    );
  }

  SsiPickerConfig merge(SsiPickerConfig? other) {
    if (other == null) return this;
    return copyWith(
        backgroundColor: other.backgroundColor,
        cancelTextStyle: cancelTextStyle?.merge(other.cancelTextStyle) ??
            other.cancelTextStyle,
        confirmTextStyle: confirmTextStyle?.merge(other.confirmTextStyle) ??
            other.confirmTextStyle,
        titleTextStyle:
            titleTextStyle?.merge(other.titleTextStyle) ?? other.titleTextStyle,
        pickerHeight: other.pickerHeight,
        titleHeight: other.titleHeight,
        itemHeight: other.itemHeight,
        itemTextStyle:
            itemTextStyle?.merge(other.itemTextStyle) ?? other.itemTextStyle,
        itemTextSelectedStyle:
            itemTextSelectedStyle?.merge(other.itemTextSelectedStyle) ??
                other.itemTextSelectedStyle,
        dividerColor: other.dividerColor,
        cornerRadius: other.cornerRadius);
  }
}
