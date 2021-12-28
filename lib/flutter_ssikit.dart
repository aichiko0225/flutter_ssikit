// ignore: library_names
library Ssikit;

// 主题
export 'src/theme/ssi_theme.dart';

//工具类 和 资源
export 'src/components/toast/ssi_toast.dart';
export 'src/components/loading/ssi_loading.dart';
export 'src/components/loading/ssi_cupertino_activityIndicator.dart';
export 'src/constants/ssi_asset_constants.dart';
export 'src/utils/ssi_tools.dart';

//文本
export 'src/components/text/ssi_expandable_text.dart';

//通知栏
export 'src/components/noticebar/ssi_notice_bar.dart';


import 'package:flutter/services.dart';

class FlutterSsikit {
  static const MethodChannel _channel = MethodChannel('flutter_ssikit');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
