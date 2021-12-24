
import 'package:flutter/material.dart';
import 'package:flutter_ssikit/src/theme/configs/ssi_all_config.dart';
import 'package:flutter_ssikit/src/theme/configs/ssi_common_config.dart';

/// Bruno默认配置
class SsiDefaultConfigUtils {
  ///  默认全局配置
  static SsiAllThemeConfig defaultAllConfig = SsiAllThemeConfig(
    commonConfig: defaultCommonConfig
  );

  /// 全局默认配置
  static SsiCommonConfig defaultCommonConfig = SsiCommonConfig(
    /// 主题色相关
    ///
    /// 主题色
    brandPrimary: const Color(0xFF0984F9),

    /// 主题色按下效果
    brandPrimaryTap: const Color(0x190984F9),

    /// 成功色
    brandSuccess: const Color(0xFF00AE66),

    /// 警告色
    brandWarning: const Color(0xFFFAAD14),

    /// 失败色
    brandError: const Color(0xFFFA3F3F),

    /// 重要-多用于红点色
    brandImportant: const Color(0xFFFA3F3F),

    /// 重要数值色
    brandImportantValue: const Color(0xFFFF5722),

    /// 辅助色
    brandAuxiliary: const Color(0xFF44C2FF),

    /// 文本色相关
    ///
    /// 基础文字纯黑色
    colorTextBase: const Color(0xFF222222),

    /// 基础文字重要色
    colorTextImportant: const Color(0xFF666666),

    /// 基础文字-反色
    colorTextBaseInverse: const Color(0xFFFFFFFF),

    /// 辅助文字色
    colorTextSecondary: const Color(0xFF999999),

    /// 失效或不可更改文字色
    colorTextDisabled: const Color(0xFF999999),

    /// 文本框提示暗文文字色
    colorTextHint: const Color(0xFFCCCCCC),

    /// 跟随主题色[brandPrimary]
    colorLink: const Color(0xFF0984F9),

    /// 背景色相关
    ///
    /// 组件背景色
    fillBase: const Color(0xFFFFFFFF),

    /// 页面背景色
    fillBody: const Color(0xFFF8F8F8),

    /// 遮罩背景
    fillMask: const Color(0x99000000),

    /// 边框色
    borderColorBase: const Color(0xFFF0F0F0),

    /// 分割线色
    dividerColorBase: const Color(0xFFF0F0F0),

    /// 文本字号
    ///
    /// 特殊数据展示，DIN Condensed数字字体，用于强吸引
    fontSizeDIN: 28,

    /// 标题字体
    /// 名称/页面大标题
    fontSizeHeadLg: 22,

    /// 标题字体
    /// 内容模块标题/一级标题
    fontSizeHead: 18,

    /// 子标题字体
    /// 标题/录入文字/大按钮文字/二级标题
    fontSizeSubHead: 16,

    /// 基础字体
    /// 内容副文本/普通说明文字
    fontSizeBase: 14,

    /// 辅助字体-普通
    fontSizeCaption: 12,

    ///辅助字体-小
    fontSizeCaptionSm: 11,

    /// 圆角尺寸
    radiusXs: 2.0,
    radiusSm: 4.0,
    radiusMd: 6.0,
    radiusLg: 8.0,

    /// 边框尺寸
    borderWidthSm: 0.5,
    borderWidthMd: 1,
    borderWidthLg: 2,

    /// 水平间距
    hSpacingXs: 8,
    hSpacingSm: 12,
    hSpacingMd: 16,
    hSpacingLg: 20,
    hSpacingXl: 24,
    hSpacingXxl: 42,

    /// 垂直间距
    vSpacingXs: 4,
    vSpacingSm: 8,
    vSpacingMd: 12,
    vSpacingLg: 14,
    vSpacingXl: 16,
    vSpacingXxl: 28,

    /// 图标大小
    iconSizeXxs: 8,
    iconSizeXs: 12,
    iconSizeSm: 14,
    iconSizeMd: 16,
    iconSizeLg: 32,
  );
}