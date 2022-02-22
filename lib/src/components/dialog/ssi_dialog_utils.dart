import 'package:flutter/material.dart';
import 'package:flutter_ssikit/src/theme/configs/ssi_dialog_config.dart';

import '../../../flutter_ssikit.dart';

class SsiDialogUtils {
  /// dialog标题配置
  static TextStyle getDialogTitleStyle(SsiDialogConfig? themeData) {
    return themeData?.titleTextStyle?.generateTextStyle() ??
        SsiTextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: const Color(0xff222222))
            .generateTextStyle();
  }

  /// dialog圆角配置
  static double getDialogRadius(SsiDialogConfig? themeData) {
    return themeData?.radius ?? 8;
  }
}
