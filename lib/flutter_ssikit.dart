// You have generated a new plugin project without
// specifying the `--platforms` flag. A plugin project supports no platforms is generated.
// To add platforms, run `flutter create -t plugin --platforms <platforms> .` under the same
// directory. You can also find a detailed instruction on how to add platforms in the `pubspec.yaml` at https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

// ignore: library_names
library Ssikit;

// 主题
export 'src/theme/ssi_theme.dart';

import 'package:flutter/services.dart';

class FlutterSsikit {
  static const MethodChannel _channel = MethodChannel('flutter_ssikit');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
