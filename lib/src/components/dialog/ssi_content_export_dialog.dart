import 'package:flutter/material.dart';
import 'package:flutter_ssikit/src/components/dialog/ssi_dialog_utils.dart';
import 'package:flutter_ssikit/src/theme/configs/ssi_dialog_config.dart';

import '../../../flutter_ssikit.dart';

/// 描述: 内容可扩展Dialog
// ignore: must_be_immutable
class SsiContentExportWidget extends StatelessWidget {
  /// 标题
  final String? title;

  /// 是否可关闭
  final bool isClose;

  /// 中间内容widget
  final Widget contentWidget;

  /// 提交按钮文字
  final String? submitText;

  /// 内容最大高度
  final Color? submitBgColor;

  /// 提交操作
  final VoidCallback? onSubmit;

  /// 是否展示底部操作区域
  final bool isShowOperateWidget;

  SsiDialogConfig? themeData;

  SsiContentExportWidget(this.contentWidget,
      {Key? key,
      this.title,
      this.isClose = false,
      this.submitText,
      this.onSubmit,
      this.submitBgColor,
      this.isShowOperateWidget = false,
      this.themeData})
      : super(key: key) {
    themeData ??= SsiDialogConfig();
    themeData = SsiThemeConfigurator.instance
        .getConfig(configId: themeData?.configId ?? "")
        ?.dialogConfig
        ?.merge(themeData!);
  }

  /// 当content含TextField  键盘弹起遮挡内容
  /// 因此顶级父Widget 采用SingleChildScrollView

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0x33999999),
        body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 300),
                    decoration: BoxDecoration(
                      //背景
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(
                          SsiDialogUtils.getDialogRadius(
                              themeData))), //设置四周圆角 角度
                    ),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            _generateTitleWidget(),
                            contentWidget,
                            _generateBottomWidget(context),
                          ],
                        ),
                        _generateCloseWidget(context),
                      ],
                    ),
                  ),
                )),
          ),
        ));
  }

  Widget _generateCloseWidget(BuildContext context) {
    if (isClose) {
      return Positioned(
          right: 0.0,
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: SsikitTools.getAssetImage(SsiAsset.ICON_PICKER_CLOSE),
              )));
    }
    return Container();
  }

  /// 构建Dialog标题
  Widget _generateTitleWidget() {
    return Padding(
      padding: null != title && title!.isNotEmpty
          ? const EdgeInsets.fromLTRB(20, 28, 20, 12)
          : const EdgeInsets.only(top: 20),
      child: null != title && title!.isNotEmpty
          ? Text(
              title ?? "",
              style: SsiDialogUtils.getDialogTitleStyle(themeData),
            )
          : Container(),
    );
  }

  /// 构建底部操作按钮
  Widget _generateBottomWidget(BuildContext context) {
    return Padding(
        padding: isShowOperateWidget
            ? const EdgeInsets.fromLTRB(20, 12, 20, 20)
            : const EdgeInsets.only(top: 20),
        child: isShowOperateWidget
            ? InkWell(
                child: Container(
                    decoration: BoxDecoration(
                      //背景
                      color: submitBgColor ??
                          themeData?.commonConfig?.brandPrimary,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(6.0)), //设置四周圆角 角度
                    ),
                    alignment: Alignment.center,
                    height: 48,
                    child: Text(submitText ?? "",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 18))),
                onTap: () {
                  if (onSubmit != null) onSubmit!();
                },
              )
            : Container());
  }
}
