import 'dart:ui';

import '../../../flutter_ssikit.dart';

//将标签属性 转为 相当的style
class SsiConvertUtil {
  //将标签color 转为 颜色
  static Color generateColorByString(String hexColor,
      {String defColor = 'ffffffff'}) {
    Color color =
        SsiThemeConfigurator.instance.getConfig()?.commonConfig?.brandPrimary ??
            const Color(0xFF0984F9);
    if (hexColor.isEmpty) return color;
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    hexColor = hexColor.replaceAll('0X', '');
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }

    try {
      color = Color(int.parse(hexColor, radix: 16));
    } catch (e) {}
    return color;
  }

  //将标签字体 转为 合适的字体
  static FontWeight generateFontWidgetByString(String fontWeight) {
    FontWeight defaultWeight = FontWeight.normal;
    switch (fontWeight) {
      case "Bold":
        defaultWeight = FontWeight.w600;
        break;
      case "Medium":
        defaultWeight = FontWeight.w500;
        break;
      case "Light":
        defaultWeight = FontWeight.w300;
        break;
    }
    return defaultWeight;
  }

  //将标签字体大小 转为 合适大小的字体
  static double generateFontSize(String size) {
    double defaultSize = 13;
    try {
      defaultSize = double.parse(size);
    } catch (e) {}
    return defaultSize;
  }
}
