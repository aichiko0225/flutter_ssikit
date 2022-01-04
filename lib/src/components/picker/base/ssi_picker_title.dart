import 'package:flutter_ssikit/src/theme/ssi_theme.dart';
import 'package:flutter_ssikit/src/utils/i18n/ssi_date_picker_i18n.dart';

import 'ssi_picker_title_config.dart';
import 'package:flutter/material.dart';

/// DatePicker's title widget.

// ignore: must_be_immutable
class SsiPickerTitle extends StatelessWidget {
  
  final SsiPickerTitleConfig pickerTitleConfig;
  final DateTimePickerLocale locale;
  final VoidCallback? onCancel, onConfirm;

  SsiPickerConfig? themeData;

  SsiPickerTitle(
      {Key? key,
      this.onCancel,
      this.onConfirm,
      this.locale = DateTimePickerLocale.zh_cn,
      this.pickerTitleConfig = SsiPickerTitleConfig.defaultConfig,
      SsiPickerConfig? themeData})
      : super(key: key) {
    this.themeData = SsiThemeConfigurator.instance
        .getConfig()
        ?.pickerConfig
        ?.merge(themeData);
  }

  @override
  Widget build(BuildContext context) {
    if (pickerTitleConfig.title != null) {
      return pickerTitleConfig.title!;
    }
    return Container(
      height: themeData!.titleHeight,
      decoration: ShapeDecoration(
        color: themeData!.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(themeData!.cornerRadius),
            topRight: Radius.circular(themeData!.cornerRadius),
          ),
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: themeData!.titleHeight - 0.5,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  child: _renderCancelWidget(context),
                  onTap: () {
                    if (onCancel != null) {
                      onCancel!();
                    }
                  },
                ),
                Text(
                  pickerTitleConfig.titleContent,
                  style: themeData?.titleTextStyle?.generateTextStyle(),
                ),
                GestureDetector(
                  child: _renderConfirmWidget(context),
                  onTap: () {
                    if (onConfirm != null) {
                      onConfirm!();
                    }
                  },
                ),
              ],
            ),
          ),
          Divider(
            color: themeData?.dividerColor,
            indent: 0.0,
            height: 0.5,
          ),
        ],
      ),
    );
  }

  /// render cancel button widget
  Widget _renderCancelWidget(BuildContext context) {
    Widget? cancelWidget = pickerTitleConfig.cancel;
    if (cancelWidget == null) {
      TextStyle? textStyle = themeData?.cancelTextStyle?.generateTextStyle();
      cancelWidget = Text(
        '取消',
        style: textStyle,
        textAlign: TextAlign.left,
      );
    }
    return cancelWidget;
  }

  /// render confirm button widget
  Widget _renderConfirmWidget(BuildContext context) {
    Widget? confirmWidget = pickerTitleConfig.confirm;
    if (confirmWidget == null) {
      TextStyle? textStyle = themeData?.confirmTextStyle?.generateTextStyle();
      confirmWidget = Text(
        '完成',
        style: textStyle,
        textAlign: TextAlign.right,
      );
    }
    return confirmWidget;
  }
}
