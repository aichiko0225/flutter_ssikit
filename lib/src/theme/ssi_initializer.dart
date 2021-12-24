import 'package:flutter_ssikit/src/theme/ssi_theme_configurator.dart';
import 'package:flutter_ssikit/src/theme/configs/ssi_all_config.dart';
import 'package:flutter_ssikit/src/theme/img/ssi_theme_img_utils.dart';

///flutter_ssikit初始化

class SsiInitializer {
  /// 手动注册时，默认注册渠道是 GLOBAL_CONFIG_ID
  static register(
      {SsiAllThemeConfig? allThemeConfig,
      String configId = SsiThemeConfigurator.GLOBAL_CONFIG_ID,
      SsiThemeImgUtils? ssikitImgUtils}) {
    /// 配置图片
    if (ssikitImgUtils != null) {
      // SsiThemeImg.register(ssikitImgUtils: ssikitImgUtils);
    }

    /// 配置主题定制
    SsiThemeConfigurator.instance.register(allThemeConfig, configId: configId);
  }
}
