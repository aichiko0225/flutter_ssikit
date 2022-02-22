import '../../../flutter_ssikit.dart';

/// 按钮基础配置
class SsiButtonConfig extends SsiBaseConfig {
  ///遵循外部主题配置，Bruno默认配置[SsiDefaultConfigUtils.defaultButtonConfig]
  SsiButtonConfig({
    this.bigButtonRadius = 6,
    this.bigButtonHeight = 48,
    this.bigButtonFontSize = 16,
    this.smallButtonRadius = 4,
    this.smallButtonHeight = 32,
    this.smallButtonFontSize = 14,
    String configId = SsiThemeConfigurator.GLOBAL_CONFIG_ID,
  }) : super(configId: configId);

  /// default value is 6
  double bigButtonRadius;

  /// default value is 48
  double bigButtonHeight;

  /// default value is 16
  double bigButtonFontSize;

  /// default value is 4
  double smallButtonRadius;

  /// default value is 32
  double smallButtonHeight;

  /// default value is 14
  double smallButtonFontSize;

  SsiButtonConfig copyWith(
      {double? bigButtonRadius,
      double? bigButtonHeight,
      double? bigButtonFontSize,
      double? smallButtonRadius,
      double? smallButtonHeight,
      double? smallButtonFontSize}) {
    return SsiButtonConfig(
      bigButtonRadius: bigButtonRadius ?? this.bigButtonRadius,
      bigButtonHeight: bigButtonHeight ?? this.bigButtonHeight,
      bigButtonFontSize: bigButtonFontSize ?? this.bigButtonFontSize,
      smallButtonRadius: smallButtonRadius ?? this.smallButtonRadius,
      smallButtonHeight: smallButtonHeight ?? this.smallButtonHeight,
      smallButtonFontSize: smallButtonFontSize ?? this.smallButtonFontSize,
    );
  }

  SsiButtonConfig merge(SsiButtonConfig? other) {
    if (other == null) return this;
    return copyWith(
        bigButtonRadius: other.bigButtonRadius,
        bigButtonHeight: other.bigButtonHeight,
        bigButtonFontSize: other.bigButtonFontSize,
        smallButtonRadius: other.smallButtonRadius,
        smallButtonHeight: other.smallButtonHeight,
        smallButtonFontSize: other.smallButtonFontSize);
  }
}
