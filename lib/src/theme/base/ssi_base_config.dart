
import 'package:flutter_ssikit/src/theme/configs/ssi_common_config.dart';
import 'package:flutter_ssikit/src/theme/ssi_theme_configurator.dart';

/// 组件配置基类
abstract class SsiBaseConfig {
  String configId;

  SsiCommonConfig? _currentLevelCommonConfig;

  SsiBaseConfig(
      {this.configId = SsiThemeConfigurator.GLOBAL_CONFIG_ID, bool autoFlatConfig = false}) {
    if (autoFlatConfig) {
      initThemeConfig(configId);
    }
  }

  /// 部分代码示意如下：
  /// cardTitleConfig.detailTextStyle.merge(SsiTextStyle(
  ///       color: commonConfig.colorTextBase,
  ///       fontSize: commonConfig.fontSizeBase,
  ///     ).merge(detailTextStyle));
  /// 第一步 以commonConfig字段为基础merge detailTextStyle  detailTextStyle 字段优先级高
  /// 当detailTextStyle中字段(如：color)为null时会使用commonConfig.colorTextBase
  /// 第二步 以默认上一级配置为基础merge  第一步结果，当第一步中字段(如：color)为空时 ,
  /// 使用上一层级配置的color(cardTitleConfig.detailTextStyle.color)
  void initThemeConfig(String configId, {SsiCommonConfig? currentLevelCommonConfig}) {
    _currentLevelCommonConfig = currentLevelCommonConfig;
  }

  /// 当自定义组件的配置时调用
  /// 根据自定义时传入的configId对配置字段打平
  void initThemeConfigPersonal() {
    initThemeConfig(configId);
  }

  SsiCommonConfig? get commonConfig =>
      _currentLevelCommonConfig ??
      SsiThemeConfigurator.instance.getConfig(configId: configId)?.commonConfig;
}
