import 'package:flutter/material.dart';
import 'package:flutter_ssikit/src/components/button/ssi_big_main_button.dart';
import 'package:flutter_ssikit/src/components/dialog/ssi_dialog.dart';
import 'package:flutter_ssikit/src/theme/configs/ssi_dialog_config.dart';

import '../../../flutter_ssikit.dart';

class SsiDialogConstants {
  /// 提示图标
  static const int ICON_ALERT = 0;

  /// 警示图标
  static const int ICON_WARNING = 1;

  /// 成功图标
  static const int ICON_SUCCESS = 2;

  /// 自定义图标
  static const int ICON_CUSTOM = 100;

  /// icon地址列表
  static const List shareItemImagePathList = [
    SsiAsset.iconAlert,
    SsiAsset.iconWarning,
    SsiAsset.iconSuccess,
  ];
}

/// 用于显示在屏幕中间展示重要信息，具有强操作的提示dialog
/// 含有纵向单按钮和双按钮
// ignore: must_be_immutable
class SsiEnhanceOperationDialog extends StatelessWidget {
  /// 构建环境上下文
  final BuildContext context;

  /// 图片类型，默认 0，[SsiDialogConstants.ICON_ALERT]
  final int? iconType;

  /// 自定义图标
  final Widget? customIconWidget;

  /// 弹框标题文案，为空则不显示标题
  final String? titleText;

  /// 弹框辅助信息文案，为空则不显示辅助信息
  final String? descText;

  /// 主要按钮文本
  final String? mainButtonText;

  /// 次要按钮文案，为空则不显示次要按钮
  final String? secondaryButtonText;

  /// 主要按钮回调
  final VoidCallback? onMainButtonClick;

  /// 次要按钮回调
  final VoidCallback? onSecondaryButtonClick;

  /// 主题配置
  SsiDialogConfig? themeData;

  SsiEnhanceOperationDialog({
    this.iconType,
    this.customIconWidget,
    required this.context,
    this.titleText,
    this.descText,
    this.mainButtonText,
    this.secondaryButtonText,
    this.onMainButtonClick,
    this.onSecondaryButtonClick,
    this.themeData,
  }) {
    themeData ??= SsiDialogConfig();
    themeData = SsiThemeConfigurator.instance
        .getConfig(configId: themeData?.configId ?? "")
        ?.dialogConfig
        ?.merge(themeData!);
  }

  @override
  Widget build(BuildContext context) {
    var icon = (iconType == SsiDialogConstants.ICON_CUSTOM)
        ? customIconWidget!
        : (SsikitTools.getAssetImage(
            SsiDialogConstants.shareItemImagePathList[iconType ?? 0]));
    return Material(
      type: MaterialType.transparency,
      child: SsiDialog(
        themeData: themeData,
        iconImage: icon,
        titleText: titleText,
        messageText: descText,
        warningWidget: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _configDialogWidgets(context),
          ),
        ),
      ),
    );
  }

  /// 弹出dialog
  show() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return this;
        }).then((value) {
      if (value == mainButtonText) {
        if (onMainButtonClick != null) {
          onMainButtonClick!();
        }
      } else {
        if (onSecondaryButtonClick != null) {
          onSecondaryButtonClick!();
        }
      }
    });
  }

  /// 构建widgets框架
  List<Widget> _configDialogWidgets(BuildContext context) {
    List<Widget> widgets = [];
    //分割
    widgets.add(Container(
      height: 16,
      color: Colors.transparent,
    ));
    // 主要按钮
    widgets.add(_configMainButton(context));
    // 次要按钮相关
    if (secondaryButtonText != null) {
      //分割
      widgets.add(Container(
        height: 16,
        color: Colors.transparent,
      ));
      //次要按钮
      widgets.add(_configSecondaryButton(context));
    }
    return widgets;
  }

  /// 构建主按钮widget
  Widget _configMainButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SsiBigMainButton(
        title: mainButtonText ?? "",
        onTap: () {
          Navigator.of(context).pop(mainButtonText);
        },
      ),
    );
  }

  /// 构建次按钮widget
  Widget _configSecondaryButton(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Center(
          child: Text(
            secondaryButtonText ?? "",
            style: TextStyle(
              color: themeData!.commonConfig!.brandPrimary!,
              fontSize: 16,
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).pop(onSecondaryButtonClick);
        },
      ),
    );
  }
}
