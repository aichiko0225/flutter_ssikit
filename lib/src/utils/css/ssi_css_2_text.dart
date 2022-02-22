import 'package:flutter/material.dart';
import 'package:flutter_ssikit/src/utils/css/ssi_core_funtion.dart';

/// 将CSS格式的标签转为文本
class SsiCSS2Text {
  static TextSpan toTextSpan(String htmlContent,
      {SsiHyperLinkCallback? linksCallback, TextStyle? defaultStyle}) {
    return TextSpan(
      children: SsiConvert(htmlContent,
              linkCallBack: linksCallback, defaultStyle: defaultStyle)
          .convert(),
    );
  }

  static Text toTextView(String htmlContent,
      {SsiHyperLinkCallback? linksCallback,
      TextStyle? defaultStyle,
      int? maxLines,
      TextAlign? textAlign,
      TextOverflow? textOverflow}) {
    return Text.rich(
      toTextSpan(htmlContent,
          linksCallback: linksCallback, defaultStyle: defaultStyle),
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: textOverflow ?? TextOverflow.clip,
    );
  }
}
