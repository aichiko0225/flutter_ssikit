// ignore_for_file: constant_identifier_names, prefer_conditional_assignment

import 'package:flutter_ssikit/src/theme/configs/ssi_default_config_utils.dart';
import 'package:flutter_ssikit/src/theme/ssi_theme.dart';
import 'package:flutter_ssikit/src/theme/configs/ssi_all_config.dart';

class SsiThemeConfigurator {
  static const String BRUNO_CONFIG_ID = 'BRUNO_CONFIG_ID';
  static const String GLOBAL_CONFIG_ID = 'GLOBAL_CONFIG_ID';

  static final SsiThemeConfigurator _instance = SsiThemeConfigurator._();
  Map<String, SsiAllThemeConfig> globalConfig = {};

  SsiThemeConfigurator._();

  static SsiThemeConfigurator get instance {
    return _instance;
  }

  /// 手动注册时，默认注册渠道是 GLOBAL_CONFIG_ID
  void register(SsiAllThemeConfig? allThemeConfig, {String configId = GLOBAL_CONFIG_ID}) {

    /// 先赋值默认配置
    checkAndInitBrunoConfig();

    /// 打平内部字段
    allThemeConfig?.initThemeConfig(configId);

    /// 赋值传入配置
    if (allThemeConfig != null) {
      instance.globalConfig[configId] = allThemeConfig;
    }
  }

  /// 获取合适的配置
  /// 1、获取 configId 对应的全局主题配置，
  /// 2、若获取的为 null，则使用默认的全局配置。
  /// 3、若没有配置 GLOBAL_CONFIG_ID ，则使用 SSIKIT 的配置。
  SsiAllThemeConfig? getConfig({String configId = GLOBAL_CONFIG_ID}) {
    checkAndInitBrunoConfig();

    SsiAllThemeConfig? allThemeConfig = globalConfig[configId];
    if (allThemeConfig == null) {
      allThemeConfig = globalConfig[GLOBAL_CONFIG_ID];
    }
    if (allThemeConfig == null) {
      allThemeConfig = globalConfig[BRUNO_CONFIG_ID];
    }
    return allThemeConfig;
  }

  /// 检查是否有默认配置
  bool isSsikitConfig() {
    return globalConfig[BRUNO_CONFIG_ID] != null;
  }

  /// 没有默认配置 配置默认配置
  void checkAndInitBrunoConfig() {
    if (!isSsikitConfig()) {
      globalConfig[BRUNO_CONFIG_ID] = SsiDefaultConfigUtils.defaultAllConfig;
    }
  }
}
