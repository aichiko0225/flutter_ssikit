import 'package:flutter/material.dart';
import 'package:flutter_ssikit/src/components/dialog/ssi_dialog_utils.dart';
import 'package:flutter_ssikit/src/theme/configs/ssi_dialog_config.dart';

import '../../../flutter_ssikit.dart';

typedef SsiSingleSelectOnSubmitCallback = Function(String data);
typedef SsiSingleSelectOnItemClickCallback = void Function(
    BuildContext dialogContext, int index);

/// 单选列表弹框
class SsiSingleSelectDialog extends Dialog {
  /// 用于控制是否可以响应点击外部关闭弹窗，true 关闭，false 不关闭，默认 true
  final bool isClose;

  /// 弹窗标题
  final String title;

  /// 时间区间最大值
  final List<String>? conditions;

  /// 确定/提交 按钮文案，默认 '提交'
  final String submitText;

  /// 提交按钮点击回调
  final SsiSingleSelectOnSubmitCallback? onSubmitClick;

  /// item 点击回调
  final SsiSingleSelectOnItemClickCallback? onItemClick;

  /// 提交按钮背景颜色
  final Color? submitBgColor;

  /// 选中的选项名称
  final String? checkedItem;

  /// 单选列表底部自定义 Widget
  final Widget? customWidget;

  /// 内容是否可滑动。默认为 true
  final bool isCustomFollowScroll;

  /// 是否在点击时让 Diallog 消失，默认为 true
  final bool canDismissOnConfirmClick;

  const SsiSingleSelectDialog(
      {this.isClose = true,
      this.title = "",
      this.conditions,
      this.submitText = "提交",
      this.submitBgColor,
      this.onSubmitClick,
      this.onItemClick,
      this.checkedItem,
      this.customWidget,
      this.canDismissOnConfirmClick = true,
      this.isCustomFollowScroll = true});

  @override
  Widget build(BuildContext context) {
    return SsiSingleSelectDialogWidget(
        isClose: isClose,
        title: title,
        conditions: conditions,
        submitText: submitText,
        onSubmitClick: onSubmitClick,
        onItemClick: onItemClick,
        submitBgColor: submitBgColor,
        checkedItem: checkedItem,
        customWidget: customWidget,
        canDismissOnConfirmClick: canDismissOnConfirmClick,
        isCustomFollowScroll: isCustomFollowScroll);
  }
}

// ignore: must_be_immutable
class SsiSingleSelectDialogWidget extends StatefulWidget {
  final bool isClose;
  final String title;
  final List<String>? conditions;
  final String submitText;
  final SsiSingleSelectOnSubmitCallback? onSubmitClick;
  final SsiSingleSelectOnItemClickCallback? onItemClick; //可供埋点需求用
  final Color? submitBgColor;
  String? checkedItem; // 选择项目

  final Widget? customWidget;

  final bool isCustomFollowScroll;

  final bool canDismissOnConfirmClick;

  SsiDialogConfig? themeData;

  SsiSingleSelectDialogWidget(
      {Key? key,
      required this.isClose,
      required this.title,
      this.conditions,
      required this.submitText,
      this.submitBgColor,
      this.onSubmitClick,
      this.onItemClick,
      this.checkedItem,
      this.customWidget,
      this.isCustomFollowScroll = true,
      this.canDismissOnConfirmClick = true,
      this.themeData})
      : super(key: key) {
    themeData ??= SsiDialogConfig();
    themeData = SsiThemeConfigurator.instance
        .getConfig(configId: themeData?.configId ?? "")
        ?.dialogConfig
        ?.merge(themeData!);
  }

  @override
  State<StatefulWidget> createState() {
    return SsiSingleSelectDialogWidgetState();
  }
}

class SsiSingleSelectDialogWidgetState
    extends State<SsiSingleSelectDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0x33999999),
        body: Container(
            alignment: Alignment.center,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 300),
              decoration: BoxDecoration(
                //背景
                color: widget.themeData?.backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(
                    SsiDialogUtils.getDialogRadius(
                        widget.themeData))), //设置四周圆角 角度
              ),
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 28, 20, 12),
                        child: Text(
                          widget.title,
                          style: SsiDialogUtils.getDialogTitleStyle(
                              widget.themeData),
                        ),
                      ),
                      Container(
                        constraints: const BoxConstraints(maxHeight: 300),
                        child: widget.isCustomFollowScroll
                            ? SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) =>
                                            _buildItem(context, index),
                                        itemCount:
                                            widget.conditions?.length ?? 0),
                                    widget.customWidget != null
                                        ? Container(
                                            child: widget.customWidget,
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 20, top: 12),
                                          )
                                        : const SizedBox(
                                            width: 0,
                                            height: 0,
                                          ),
                                  ],
                                ),
                              )
                            : Column(
                                children: <Widget>[
                                  Expanded(
                                    child: ListView.builder(
                                        itemBuilder: (context, index) =>
                                            _buildItem(context, index),
                                        itemCount:
                                            widget.conditions?.length ?? 0),
                                  ),
                                  widget.customWidget != null
                                      ? Container(
                                          child: widget.customWidget,
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20, top: 12),
                                        )
                                      : const SizedBox(
                                          width: 0,
                                          height: 0,
                                        ),
                                ],
                              ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                          child: InkWell(
                            child: Container(
                                decoration: BoxDecoration(
                                  //背景
                                  color: SsiThemeConfigurator.instance
                                      .getConfig()
                                      ?.commonConfig
                                      ?.brandPrimary,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(6.0)), //设置四周圆角 角度
                                ),
                                alignment: Alignment.center,
                                height: 48,
                                color: widget.submitBgColor,
                                child: Text(widget.submitText,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 18))),
                            onTap: () {
                              if (widget.canDismissOnConfirmClick) {
                                Navigator.of(context).pop();
                              }
                              if (widget.onSubmitClick != null) {
                                widget.onSubmitClick!(widget.checkedItem ?? "");
                              }
                            },
                          ))
                    ],
                  ),
                  widget.isClose
                      ? Positioned(
                          right: 0.0,
                          child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: SsikitTools.getAssetImage(
                                    SsiAsset.ICON_PICKER_CLOSE),
                              )))
                      : Container()
                ],
              ),
            )));
  }

  Widget _buildItem(BuildContext context, int index) {
    if (widget.conditions == null) {
      return Container();
    } else {
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: InkWell(
                  onTap: () {
                    setState(() {
                      for (dynamic item in widget.conditions!) {
                        if (widget.conditions![index] == item) {
                          if (widget.onItemClick != null &&
                              widget.checkedItem != item) {
                            widget.onItemClick!(context, index);
                          }
                          widget.checkedItem = item;
                          break;
                        }
                      }
                    });
                  },
                  child: Text(widget.conditions![index],
                      style: TextStyle(
                          fontWeight:
                              widget.conditions![index] == widget.checkedItem
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                          fontSize: 16,
                          color: widget.conditions![index] == widget.checkedItem
                              ? SsiThemeConfigurator.instance
                                  .getConfig()
                                  ?.commonConfig
                                  ?.brandPrimary
                              : SsiThemeConfigurator.instance
                                  .getConfig()
                                  ?.commonConfig
                                  ?.colorTextBase)),
                )),
                InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    height: 44,
                    child: widget.checkedItem == widget.conditions![index]
                        ? SsikitTools.getAssetImageWithBandColor(
                            SsiAsset.iconSingleSelected)
                        : SsikitTools.getAssetImage(SsiAsset.iconUnSelect),
                  ),
                  onTap: () {
                    if (widget.onItemClick != null) {
                      widget.onItemClick!(context, index);
                    }
                    setState(() {
                      widget.checkedItem = widget.conditions![index];
                    });
                  },
                )
              ],
            ),
          ),
          index != (widget.conditions?.length ?? 0) - 1
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0), child: SsiLine())
              : Container()
        ],
      );
    }
  }
}
