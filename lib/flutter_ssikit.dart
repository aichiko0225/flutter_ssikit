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

//actionsheet
export 'src/components/actionsheet/ssi_common_action_sheet.dart';

//选择器
export 'src/components/picker/ssi_bottom_picker.dart';
export 'src/components/picker/ssi_bottom_write_picker.dart';
export 'src/components/picker/ssi_picker_cliprrect.dart';
export 'src/components/picker/base/ssi_picker_title_config.dart';
export 'src/components/picker/time_picker/date_picker/ssi_date_picker.dart';
export 'src/components/picker/time_picker/ssi_date_time_formatter.dart';


//文本
export 'src/components/text/ssi_expandable_text.dart';

//分割线
export 'src/components/line/ssi_line.dart';
export 'src/components/line/ssi_dashed_line.dart';

//通知栏
export 'src/components/noticebar/ssi_notice_bar.dart';

// form 相关
export 'src/components/form/base/input_item_interface.dart';
export 'src/components/form/base/ssi_form_item_type.dart';
export 'src/components/form/ssi_text_input_item.dart';
export 'src/components/form/ssi_text_select_item.dart';

import 'package:flutter/services.dart';

class FlutterSsikit {
  static const MethodChannel _channel = MethodChannel('flutter_ssikit');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
