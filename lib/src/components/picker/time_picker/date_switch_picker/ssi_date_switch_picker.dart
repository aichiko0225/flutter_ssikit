// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_ssikit/src/components/picker/base/ssi_picker_title_config.dart';
import 'package:flutter_ssikit/src/components/picker/time_picker/date_switch_picker/ssi_date_time_switch_formatter.dart';
import 'package:flutter_ssikit/src/components/picker/time_picker/date_switch_picker/ssi_datetime_switch_widget.dart';
import 'package:flutter_ssikit/src/components/picker/time_picker/date_switch_picker/ssi_picker_switch_top.dart';
import 'package:flutter_ssikit/src/theme/ssi_theme.dart';
import 'package:flutter_ssikit/src/utils/i18n/ssi_date_picker_i18n.dart';

import '../../ssi_picker_cliprrect.dart';
import '../ssi_date_picker_constants.dart';
import '../ssi_date_time_formatter.dart';

///时间选择模式枚举
enum SsiDateTimeSwitchPickerMode {
  /// Display DatePicker
  date,

  /// Display TimePicker
  time,

  /// Display DateTimePicker
  datetime,
}

class SsiDateSwitchPicker {
  /// Display date picker in bottom sheet.
  ///
  /// context: [BuildContext]
  /// minDateTime: [DateTime] minimum date time
  /// maxDateTime: [DateTime] maximum date time
  /// initialDateTime: [DateTime] initial date time for selected
  /// dateFormat: [String] date format pattern
  /// locale: [DateTimePickerLocale] internationalization
  /// pickerMode: [SsiDateTimeSwitchPickerMode] display mode: date(DatePicker)、time(TimePicker)、datetime(DateTimePicker)
  /// pickerTheme: [SsiPickerTitleConfig] the theme of date time picker
  /// onCancel: [DateVoidCallback] pressed title cancel widget event
  /// onClose: [DateVoidCallback] date picker closed event
  /// onChange: [DateValueCallback] selected date time changed event
  /// onConfirm: [DateValueStartAndEndCallback] pressed title confirm widget event
  static void showDatePicker(
    BuildContext context, {

    /// If rootNavigator is set to true, the state from the furthest instance of this class is given instead.
    /// Useful for pushing contents above all subsequent instances of [Navigator].
    bool rootNavigator = false,

    /// 点击弹框外部区域能否消失
    bool canBarrierDismissible = true,

    /// 能滚动到的最小日期
    DateTime? minDateTime,

    /// 能滚动到的最大日期
    DateTime? maxDateTime,

    /// 初始选择的开始时间。默认当前时间
    DateTime? initialStartDateTime,

    /// 初始选择的结束时间。默认当前时间
    DateTime? initialEndDateTime,

    /// 时间格式化的格式
    String? dateFormat,

    /// 分钟间切换的差值
    int minuteDivider = 1,
    DateTimePickerLocale locale = DATETIME_PICKER_LOCALE_DEFAULT,

    /// 时间选择组件显示的时间类型
    SsiDateTimeSwitchPickerMode pickerMode = SsiDateTimeSwitchPickerMode.date,

    /// 时间选择组件的主题样式
    SsiPickerTitleConfig? pickerTitleConfig,

    /// 点击【取消】回调给调用方的回调事件
    DateVoidCallback? onCancel,

    /// 点击【完成】回调给调用方的数据
    DateVoidCallback? onClose,

    /// 时间滚动选择时候的回调事件
    DateValueCallback? onChange,

    /// 弹框点击外围消失的回调事件
    DateValueStartAndEndCallback? onConfirm,
    SsiPickerConfig? themeData,
    int maxTimeDifference = 7 * 24 * 60 * 60 * 1000,
  }) {
    // handle the range of datetime
    minDateTime ??= DateTime.parse(DATE_PICKER_MIN_DATETIME);
    maxDateTime ??= DateTime.parse(DATE_PICKER_MAX_DATETIME);

    // handle initial DateTime
    initialStartDateTime ??= DateTime.now();
    initialEndDateTime ??= DateTime.now();

    // Set value of date format
    dateFormat =
        DateTimeSwitchFormatter.generateDateFormat(dateFormat, pickerMode);

    Navigator.of(context, rootNavigator: rootNavigator)
        .push(
          _DatePickerRoute(
            canBarrierDismissible: canBarrierDismissible,
            minDateTime: minDateTime,
            maxDateTime: maxDateTime,
            initialStartDateTime: initialStartDateTime,
            initialEndDateTime: initialEndDateTime,
            dateFormat: dateFormat,
            minuteDivider: minuteDivider,
            locale: locale,
            pickerMode: pickerMode,
            pickerTitleConfig: pickerTitleConfig,
            onCancel: onCancel,
            onChange: onChange,
            onConfirm: onConfirm,
            theme: Theme.of(context),
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            themeData: themeData,
            maxTimeDifference: maxTimeDifference,
          ),
        )
        .whenComplete(onClose ?? () {});
  }
}

class _DatePickerRoute<T> extends PopupRoute<T> {
  _DatePickerRoute({
    this.minDateTime,
    this.maxDateTime,
    this.initialStartDateTime,
    this.initialEndDateTime,
    this.minuteDivider = 1,
    this.dateFormat,
    this.locale = DateTimePickerLocale.zh_cn,
    required this.pickerMode,
    this.pickerTitleConfig,
    this.onCancel,
    this.onChange,
    this.onConfirm,
    required this.theme,
    required this.barrierLabel,
    required this.canBarrierDismissible,
    required this.maxTimeDifference,
    RouteSettings? settings,
    SsiPickerConfig? themeData,
  }) : super(settings: settings) {
    this.themeData = SsiThemeConfigurator.instance
        .getConfig()
        ?.pickerConfig
        ?.merge(themeData);
  }

  final DateTime? minDateTime, maxDateTime, initialStartDateTime,initialEndDateTime;
  final String? dateFormat;

  final DateTimePickerLocale locale;
  final SsiDateTimeSwitchPickerMode pickerMode;

  final SsiPickerTitleConfig? pickerTitleConfig;
  final VoidCallback? onCancel;
  final DateValueCallback? onChange;
  final DateValueStartAndEndCallback? onConfirm;

  bool canBarrierDismissible;
  final int minuteDivider;
  final ThemeData theme;
  final int maxTimeDifference;

  SsiPickerConfig? themeData;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  bool get barrierDismissible => canBarrierDismissible;

  @override
  final String barrierLabel;

  @override
  Color get barrierColor => Colors.black54;

  AnimationController? _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController = BottomSheet.createAnimationController(
        navigator?.overlay as TickerProviderStateMixin);
    return _animationController!;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    Widget bottomSheet = MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: _DatePickerComponent(route: this),
    );

    bottomSheet = Theme(data: theme, child: bottomSheet);
    return bottomSheet;
  }
}

// ignore: must_be_immutable
class _DatePickerComponent extends StatelessWidget {
  final _DatePickerRoute route;

  _DatePickerComponent({required this.route});

  @override
  Widget build(BuildContext context) {
    Widget? pickerWidget;
    switch (route.pickerMode) {
      // case SsiDateTimeSwitchPickerMode.date:
      //   pickerWidget = SsiDateWidget(
      //     minDateTime: route.minDateTime,
      //     maxDateTime: route.maxDateTime,
      //     initialDateTime: route.initialDateTime,
      //     dateFormat: route.dateFormat,
      //     locale: route.locale,
      //     pickerTitleConfig: route.pickerTitleConfig,
      //     onCancel: route.onCancel,
      //     onChange: route.onChange,
      //     onConfirm: route.onConfirm,
      //     themeData: route.themeData,
      //   );
      //   break;
      // case SsiDateTimeSwitchPickerMode.time:
      //   pickerWidget = SsiTimeWidget(
      //     minDateTime: route.minDateTime,
      //     maxDateTime: route.maxDateTime,
      //     initDateTime: route.initialDateTime,
      //     dateFormat: route.dateFormat,
      //     locale: route.locale,
      //     minuteDivider: route.minuteDivider,
      //     pickerTitleConfig: route.pickerTitleConfig,
      //     onCancel: route.onCancel,
      //     onChange: route.onChange,
      //     onConfirm: route.onConfirm,
      //     themeData: route.themeData,
      //   );
      //   break;
      case SsiDateTimeSwitchPickerMode.datetime:
        pickerWidget = SsiPickerSwitchTop(
          startMinTime: route.minDateTime,
          startMaxTime: route.maxDateTime,
          currentStartTime: route.initialStartDateTime,
          currentEndTime: route.initialEndDateTime,
          dateFormat: route.dateFormat,
          minuteDivider: route.minuteDivider,
          locale: route.locale,
          onChange: route.onChange,
          onConfirm: route.onConfirm,
          maxTimeDifference: 7 * 24 * 60 * 60 * 1000,
        );
        break;
    }
    return GestureDetector(
      child: AnimatedBuilder(
        animation: route.animation!,
        builder: (BuildContext context, Widget? child) {
          return ClipRect(
            child: CustomSingleChildLayout(
              delegate: _BottomPickerLayout(route.animation?.value ?? 0),
              child: SsiPickerClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(route.themeData?.cornerRadius ?? 8),
                  topRight: Radius.circular(route.themeData?.cornerRadius ?? 8),
                ),
                child: Column(
                  children: [
                    pickerWidget!,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BottomPickerLayout extends SingleChildLayoutDelegate {
  _BottomPickerLayout(this.progress);

  final double progress;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      minHeight: 0.0,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double height = size.height - childSize.height * progress;
    return Offset(0.0, height);
  }

  @override
  bool shouldRelayout(_BottomPickerLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
