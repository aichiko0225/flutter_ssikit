import 'package:flutter_ssikit/src/theme/configs/ssi_common_config.dart';
import 'package:flutter_ssikit/src/theme/ssi_theme.dart';
import 'package:flutter_ssikit/src/theme/ssi_theme_configurator.dart';

/// 描述: 全局配置
///
/// 当用户使用时对单个组件自定义配置，优先走单个组件特定配置（作用范围档次使用）
/// 当用户配置组件通用配置时如[SsiDialogConfig]优先使用该配置
/// 若没有配置组件通用配置，走[SsiCommonConfig]全局配置
/// 如果以上都没有配置走Ssikit默认配置即[SsiDefaultConfigUtils]中配置
/// 当没有配置组件的特定属性时使用上一级特定配置
///
class SsiAllThemeConfig {
  SsiCommonConfig? commonConfig;

  SsiAllThemeConfig({this.commonConfig, String configId = SsiThemeConfigurator.GLOBAL_CONFIG_ID});

  void initThemeConfig(String configId) {}
}
