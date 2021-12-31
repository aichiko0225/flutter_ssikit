import '../base/ssi_base_config.dart';
import '../base/ssi_text_style.dart';
import '../../theme/ssi_theme_configurator.dart';
import '../../theme/configs/ssi_common_config.dart';
import 'package:flutter/material.dart';

/// 描述: form 表单项主配置类
class SsiFormItemConfig extends SsiBaseConfig {
  /// 左侧标题文本样式
  /// default SsiTextStyle(color: [SsiCommonConfig.colorTextBase],fontSize: [SsiCommonConfig.fontSizeHead])
  SsiTextStyle? headTitleTextStyle;

  /// 左侧标题文本样式
  /// default SsiTextStyle(color: [SsiCommonConfig.colorTextBase],fontSize: [SsiCommonConfig.fontSizeSubHead])
  SsiTextStyle? titleTextStyle;

  /// 左侧辅助文本样式
  /// default SsiTextStyle(color: [SsiCommonConfig.colorTextSecondary], fontSize: [SsiCommonConfig.fontSizeCaption])
  SsiTextStyle? subTitleTextStyle;

  /// 左侧Error文本样式
  /// default SsiTextStyle(color: [SsiCommonConfig.brandError], fontSize: [SsiCommonConfig.fontSizeCaption])
  SsiTextStyle? errorTextStyle;

  /// 右侧 输入、选择提示文本样式
  /// default SsiTextStyle(color: [SsiCommonConfig.colorTextHint], fontSize: [SsiCommonConfig.fontSizeSubHead]）
  SsiTextStyle? hintTextStyle;

  /// 右侧 主要内容样式
  /// default SsiTextStyle([SsiCommonConfig.colorTextBase]), fontSize: [SsiCommonConfig.fontSizeSubHead])
  SsiTextStyle? contentTextStyle;

  /// 表单项 当有星号标识 上下右边距
  /// default EdgeInsets.only(left: 0, top: [SsiCommonConfig.vSpacingLg], right: [SsiCommonConfig.hSpacingLg], bottom: [SsiCommonConfig.vSpacingLg])
  EdgeInsets? formPadding;

  /// 表单项 当有星号标识 左边距
  /// default EdgeInsets.only(left: 10)
  EdgeInsets? titlePaddingSm;

  /// 表单项 当无星号标识 左右边距
  /// default EdgeInsets.only(left: [SsiCommonConfig.hSpacingLg])
  EdgeInsets? titlePaddingLg;

  /// 选项之间间距 单选 or 多选
  /// default EdgeInsets.only(left: [SsiCommonConfig.hSpacingMd])
  EdgeInsets? optionsMiddlePadding;

  /// 选项普通文本样式
  /// TextStyle(color: [SsiCommonConfig.colorTextBase], height: 1.3, fontSize: [SsiCommonConfig.fontSizeSubHead],)
  SsiTextStyle? optionTextStyle;

  /// 选项选中文本样式
  /// TextStyle(color: [SsiCommonConfig.brandPrimary], height: 1.3, fontSize: [SsiCommonConfig.fontSizeSubHead],)
  SsiTextStyle? optionSelectedTextStyle;

  /// 子标题 左上间距
  /// default EdgeInsets.only(left: [SsiCommonConfig.hSpacingLg], top: [SsiCommonConfig.vSpacingXs])
  EdgeInsets? subTitlePadding;

  /// error提示 左上间距
  /// EdgeInsets.only(left: [SsiCommonConfig.hSpacingLg], top: [SsiCommonConfig.vSpacingXs])
  EdgeInsets? errorPadding;

  /// 不可修改内容展示
  /// SsiTextStyle(color: [SsiCommonConfig.colorTextDisabled],fontSize: [SsiCommonConfig.fontSizeSubHead])
  SsiTextStyle? disableTextStyle;

  /// 提示文本样式
  /// SsiTextStyle(color: [SsiCommonConfig.colorTextSecondary], fontSize: [SsiCommonConfig.fontSizeBase])
  SsiTextStyle? tipsTextStyle;

  SsiFormItemConfig.generatorFromConfigId(String configId) {
    initThemeConfig(configId);
  }

  SsiFormItemConfig(
      {this.titleTextStyle,
      this.subTitleTextStyle,
      this.errorTextStyle,
      this.hintTextStyle,
      this.contentTextStyle,
      this.formPadding,
      this.titlePaddingSm,
      this.titlePaddingLg,
      this.optionsMiddlePadding,
      this.subTitlePadding,
      this.errorPadding,
      this.disableTextStyle,
      this.tipsTextStyle,
      this.headTitleTextStyle,
      this.optionTextStyle,
      this.optionSelectedTextStyle,
      String configId = SsiThemeConfigurator.GLOBAL_CONFIG_ID})
      : super(configId: configId);

  /// 举例：
  /// ① 尝试获取最近的配置 [topRadius] 若配不为 null，直接使用该配置.
  /// ② [topRadius] 若为 null，尝试使用 全局配置中的配置 SsiFormItemConfig.
  /// ③ 如果全局配置中的配置同样为 null 则根据 [configId] 取出全局配置。
  /// ④ 如果没有配置 [configId] 的全局配置，则使用 Ssikit 默认的配置
  @override
  void initThemeConfig(String configId, {SsiCommonConfig? currentLevelCommonConfig}) {
    super.initThemeConfig(configId, currentLevelCommonConfig: currentLevelCommonConfig);

    /// 用户全局form组件配置
    SsiFormItemConfig? formItemThemeData =
        SsiThemeConfigurator.instance.getConfig(configId: configId)?.formItemConfig;

    titlePaddingSm ??= formItemThemeData?.titlePaddingSm;

    titlePaddingLg ??= formItemThemeData?.titlePaddingLg;

    optionSelectedTextStyle = formItemThemeData?.optionSelectedTextStyle?.merge(SsiTextStyle(
      color: commonConfig?.brandPrimary,
      fontSize: commonConfig?.fontSizeSubHead,
    ).merge(optionSelectedTextStyle));

    optionTextStyle = formItemThemeData?.optionTextStyle?.merge(
        SsiTextStyle(color: commonConfig?.colorTextBase, fontSize: commonConfig?.fontSizeSubHead)
            .merge(optionTextStyle));

    headTitleTextStyle = formItemThemeData?.headTitleTextStyle?.merge(
        SsiTextStyle(color: commonConfig?.colorTextBase, fontSize: commonConfig?.fontSizeHead)
            .merge(headTitleTextStyle));

    errorPadding ??= EdgeInsets.only(
        left: commonConfig?.hSpacingLg ?? 20,
        right: formItemThemeData?.errorPadding?.right ?? 0,
        top: commonConfig?.vSpacingXs ?? 4,
        bottom: formItemThemeData?.errorPadding?.bottom ?? 0,
      );

    subTitlePadding ??= EdgeInsets.only(
        left: commonConfig?.hSpacingLg ?? 20,
        right: formItemThemeData?.subTitlePadding?.right ?? 0,
        top: commonConfig?.vSpacingXs ?? 4,
        bottom: formItemThemeData?.subTitlePadding?.bottom ?? 0,
      );

    formPadding ??= EdgeInsets.only(
          left: formItemThemeData?.formPadding?.left ?? 0,
          right: commonConfig?.hSpacingLg ?? 20,
          top: commonConfig?.vSpacingLg ?? 14,
          bottom: commonConfig?.vSpacingLg ?? 14);

    tipsTextStyle = formItemThemeData?.tipsTextStyle?.merge(
        SsiTextStyle(color: commonConfig?.colorTextSecondary, fontSize: commonConfig?.fontSizeBase)
            .merge(tipsTextStyle));

    disableTextStyle = formItemThemeData?.disableTextStyle?.merge(
        SsiTextStyle(color: commonConfig?.colorTextDisabled, fontSize: commonConfig?.fontSizeSubHead)
            .merge(disableTextStyle));

    contentTextStyle = formItemThemeData?.contentTextStyle?.merge(
        SsiTextStyle(color: commonConfig?.colorTextBase, fontSize: commonConfig?.fontSizeSubHead)
            .merge(contentTextStyle));

    hintTextStyle = formItemThemeData?.hintTextStyle?.merge(
        SsiTextStyle(color: commonConfig?.colorTextHint, fontSize: commonConfig?.fontSizeSubHead)
            .merge(hintTextStyle));

    titleTextStyle = formItemThemeData?.titleTextStyle?.merge(
        SsiTextStyle(color: commonConfig?.colorTextBase, fontSize: commonConfig?.fontSizeSubHead)
            .merge(titleTextStyle));

    subTitleTextStyle = formItemThemeData?.subTitleTextStyle?.merge(
        SsiTextStyle(color: commonConfig?.colorTextSecondary, fontSize: commonConfig?.fontSizeCaption)
            .merge(subTitleTextStyle));

    errorTextStyle = formItemThemeData?.errorTextStyle?.merge(
        SsiTextStyle(color: commonConfig?.brandError, fontSize: commonConfig?.fontSizeCaption)
            .merge(errorTextStyle));

    optionsMiddlePadding ??= formItemThemeData?.optionsMiddlePadding;
  }

  SsiFormItemConfig copyWith({
    SsiTextStyle? titleTextStyle,
    SsiTextStyle? subTitleTextStyle,
    SsiTextStyle? errorTextStyle,
    SsiTextStyle? hintTextStyle,
    SsiTextStyle? contentTextStyle,
    EdgeInsets? formPadding,
    EdgeInsets? titlePaddingSm,
    EdgeInsets? titlePaddingLg,
    EdgeInsets? optionsMiddlePadding,
    EdgeInsets? subTitlePadding,
    EdgeInsets? errorPadding,
    SsiTextStyle? disableTextStyle,
    SsiTextStyle? tipsTextStyle,
    SsiTextStyle? headTitleTextStyle,
    SsiTextStyle? optionTextStyle,
    SsiTextStyle? optionSelectedTextStyle,
  }) {
    return SsiFormItemConfig(
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      subTitleTextStyle: subTitleTextStyle ?? this.subTitleTextStyle,
      errorTextStyle: errorTextStyle ?? this.errorTextStyle,
      hintTextStyle: hintTextStyle ?? this.hintTextStyle,
      contentTextStyle: contentTextStyle ?? this.contentTextStyle,
      formPadding: formPadding ?? this.formPadding,
      titlePaddingSm: titlePaddingSm ?? this.titlePaddingSm,
      titlePaddingLg: titlePaddingLg ?? this.titlePaddingLg,
      optionsMiddlePadding: optionsMiddlePadding ?? this.optionsMiddlePadding,
      subTitlePadding: subTitlePadding ?? this.subTitlePadding,
      errorPadding: errorPadding ?? this.errorPadding,
      disableTextStyle: disableTextStyle ?? this.disableTextStyle,
      tipsTextStyle: tipsTextStyle ?? this.tipsTextStyle,
      headTitleTextStyle: headTitleTextStyle ?? this.headTitleTextStyle,
      optionTextStyle: optionTextStyle ?? this.optionTextStyle,
      optionSelectedTextStyle: optionSelectedTextStyle ?? this.optionSelectedTextStyle,
    );
  }

  SsiFormItemConfig merge(SsiFormItemConfig? other) {
    if (other == null) return this;
    return copyWith(
        titleTextStyle: titleTextStyle?.merge(other.titleTextStyle) ?? other.titleTextStyle,
        subTitleTextStyle:
            subTitleTextStyle?.merge(other.subTitleTextStyle) ?? other.subTitleTextStyle,
        errorTextStyle: errorTextStyle?.merge(other.errorTextStyle) ?? other.errorTextStyle,
        hintTextStyle: hintTextStyle?.merge(other.hintTextStyle) ?? other.hintTextStyle,
        contentTextStyle: contentTextStyle?.merge(other.contentTextStyle) ?? other.contentTextStyle,
        formPadding: other.formPadding,
        titlePaddingSm: other.titlePaddingSm,
        titlePaddingLg: other.titlePaddingLg,
        optionsMiddlePadding: other.optionsMiddlePadding,
        subTitlePadding: other.subTitlePadding,
        errorPadding: other.errorPadding,
        disableTextStyle: disableTextStyle?.merge(other.disableTextStyle) ?? other.disableTextStyle,
        tipsTextStyle: tipsTextStyle?.merge(other.tipsTextStyle) ?? other.tipsTextStyle,
        headTitleTextStyle:
            headTitleTextStyle?.merge(other.headTitleTextStyle) ?? other.headTitleTextStyle,
        optionTextStyle: optionTextStyle?.merge(other.optionTextStyle) ?? other.optionTextStyle,
        optionSelectedTextStyle: optionSelectedTextStyle?.merge(other.optionSelectedTextStyle) ??
            other.optionSelectedTextStyle);
  }
}
