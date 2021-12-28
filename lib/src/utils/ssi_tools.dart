import 'package:flutter/material.dart';
import '../constants/ssi_strings_constants.dart';

class SsikitTools {

  /// imgAssetPath: assets资源文件路径
  /// package 访问某个package里的资源，这里默认flutter_alliance_package
  /// scale: 与所用的png资源是icon_2x.png (scale=2.0)，icon_3x.png(scale=3.0)
  static Image getAssetImage(String assetFilePath, {BoxFit? fit, bool gaplessPlayback = false}) {
    if (!assetFilePath.startsWith("assets")) {
      assetFilePath = "assets/$assetFilePath";
    }
    return Image.asset(
      assetFilePath,
      package: SsiStrings.flutterPackageName,
      fit: fit,
      scale: 3.0,
      gaplessPlayback: gaplessPlayback,
    );
  }

  /// 根据 TextStyle 计算 text 宽度。
  static Size textSize(String text, TextStyle style) {
    if (isEmpty(text)) return Size(0, 0);
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  /// 判空
  static bool isEmpty(Object obj) {
    if (obj is String) {
      return obj.isEmpty;
    } else if (obj is Iterable) {
      return obj.isEmpty;
    } else if (obj is Map) {
      return obj.length == 0;
    }
    return obj == null;
  }
}
