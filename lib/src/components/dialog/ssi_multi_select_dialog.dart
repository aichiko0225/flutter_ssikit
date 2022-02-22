import 'package:flutter/material.dart';
import 'package:flutter_ssikit/src/components/dialog/ssi_content_export_dialog.dart';
import 'package:flutter_ssikit/src/components/dialog/ssi_dialog.dart';

import '../../../flutter_ssikit.dart';

typedef SsiMultiSelectDialogClickSubmitCallback = bool Function(
    List<MultiSelectItem> data);
typedef SsiMultiSelectDialogOnItemClickCallback = void Function(
    BuildContext dialogContext, int index);

/// 多选item
class MultiSelectItem {
  /// 选项编号
  String code;

  /// 选项内容
  String content;

  /// 是否选中
  bool isChecked;

  MultiSelectItem(this.code, this.content, {this.isChecked: false});
}

/// 屏幕中间弹出多选列表弹框
/// 多用于反馈场景底部有操作按钮，可支持自定义底部操作区域

class SsiMultiSelectDialog extends Dialog {
  /// 是否可关闭  默认true 可关闭
  final bool isClose;

  /// 标题
  final String title;

  /// 描述文案
  final String? messageText;

  /// 描述widget
  final Widget? messageWidget;

  /// 选项集合
  final List<MultiSelectItem>? conditions;

  /// 操作按钮文案
  final String submitText;

  /// 点击操作按钮
  final SsiMultiSelectDialogClickSubmitCallback? onSubmitClick;

  /// 点击选项操作 可供埋点需求用
  final SsiMultiSelectDialogOnItemClickCallback? onItemClick;

  /// 操作按钮背景色
  final Color? submitBgColor;

  /// 自定义widget
  final Widget? customWidget;

  /// 是否支持滚动 默认true支持滚动
  final bool isCustomFollowScroll;

  /// 是否展示底部操作区域 默认true展示
  final bool isShowOperateWidget;

  SsiMultiSelectDialog({
    this.isClose = true,
    this.title = "",
    this.conditions,
    this.messageText,
    this.messageWidget,
    this.customWidget,
    this.isCustomFollowScroll = true,
    this.submitText = "提交",
    this.submitBgColor,
    this.onSubmitClick,
    this.onItemClick,
    this.isShowOperateWidget = true,
  });

  @override
  Widget build(BuildContext context) {
    return MultiSelect(
        isClose: isClose,
        title: title,
        messageText: messageText,
        messageWidget: messageWidget,
        customWidget: customWidget,
        isCustomFollowScroll: isCustomFollowScroll,
        conditions: conditions,
        submitText: submitText,
        onSubmitClick: onSubmitClick,
        onItemClick: onItemClick,
        submitBgColor: submitBgColor ??
            SsiThemeConfigurator.instance
                .getConfig()
                ?.commonConfig
                ?.brandPrimary,
        isShowOperateWidget: isShowOperateWidget);
  }
}

class MultiSelect extends StatefulWidget {
  /// 是否可关闭
  final bool isClose;

  /// 标题
  final String? title;

  /// 描述文案
  final String? messageText;

  /// 描述widget
  final Widget? messageWidget;

  /// 选项集合
  final List<MultiSelectItem>? conditions;

  /// 操作按钮文案
  final String? submitText;

  /// 点击操作按钮
  final SsiMultiSelectDialogClickSubmitCallback? onSubmitClick;

  /// 点击选项操作
  final SsiMultiSelectDialogOnItemClickCallback? onItemClick;

  /// 操作按钮背景色
  final Color? submitBgColor;

  /// 自定义widget
  final Widget? customWidget;

  /// 是否支持滚动
  final bool isCustomFollowScroll;

  /// 是否展示底部操作区域
  final bool isShowOperateWidget;

  MultiSelect({
    required this.isClose,
    this.title,
    this.messageText,
    this.messageWidget,
    this.customWidget,
    required this.isCustomFollowScroll,
    this.conditions,
    this.submitText,
    this.submitBgColor,
    this.onSubmitClick,
    this.onItemClick,
    required this.isShowOperateWidget,
  });

  @override
  State<StatefulWidget> createState() {
    return MultiSelectPickerWidgetState();
  }
}

class MultiSelectPickerWidgetState extends State<MultiSelect> {
  @override
  Widget build(BuildContext context) {
    return SsiContentExportWidget(
      Column(
        children: <Widget>[
          _generateContentWidget(),
          Container(
            constraints: BoxConstraints(maxHeight: 300),
            child: widget.isCustomFollowScroll
                ? SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>
                                _buildItem(context, index),
                            itemCount: widget.conditions?.length),
                        widget.customWidget != null
                            ? Container(
                                child: widget.customWidget,
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 12),
                              )
                            : Container(
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
                            itemCount: widget.conditions?.length),
                      ),
                      widget.customWidget != null
                          ? Container(
                              child: widget.customWidget,
                              padding:
                                  EdgeInsets.only(left: 20, right: 20, top: 12),
                            )
                          : Container(
                              width: 0,
                              height: 0,
                            ),
                    ],
                  ),
          )
        ],
      ),
      title: widget.title,
      isClose: widget.isClose,
      submitText: widget.submitText,
      submitBgColor: widget.submitBgColor,
      isShowOperateWidget: widget.isShowOperateWidget,
      onSubmit: () {
        List<MultiSelectItem> tempList = [];
        if (widget.onSubmitClick != null) {
          for (int i = 0; i < (widget.conditions?.length ?? 0); i++) {
            if (widget.conditions![i].isChecked) {
              tempList.add(widget.conditions![i]);
            }
          }
          if (widget.onSubmitClick!(tempList)) Navigator.of(context).pop();
        }
      },
    );
  }

  /// 内容widget 以 messageWidget 为准，
  /// 若无则以 messageText 生成widget 填充，
  /// 都没设置则为空 Container
  Widget _generateContentWidget() {
    if (widget.messageWidget != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 20, right: 20),
        child: widget.messageWidget,
      );
    }

    if (!SsikitTools.isEmpty(widget.messageText ?? "")) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 20, right: 20),
        child: Center(
          child: Text(
            widget.messageText ?? "",
            style: cContentTextStyle,
          ),
        ),
      );
    }
    return Container();
  }

  Widget _buildItem(BuildContext context, int index) {
    if (widget.conditions?[index] == null) {
      return Container();
    } else {
      return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            setState(() {
              widget.conditions![index].isChecked =
                  !widget.conditions![index].isChecked;
            });
            if (widget.onItemClick != null) {
              widget.onItemClick!(context, index);
            }
          },
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(widget.conditions![index].content,
                            style: TextStyle(
                                fontWeight: widget.conditions![index].isChecked
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                                fontSize: 16,
                                color: widget.conditions![index].isChecked
                                    ? SsiThemeConfigurator.instance
                                        .getConfig()
                                        ?.commonConfig
                                        ?.brandPrimary
                                    : SsiThemeConfigurator.instance
                                        .getConfig()
                                        ?.commonConfig
                                        ?.colorTextBase))),
                    Container(
                        alignment: Alignment.center,
                        height: 44,
                        child: widget.conditions![index].isChecked
                            ? SsikitTools.getAssetImageWithBandColor(
                                SsiAsset.iconMultiSelected)
                            : SsikitTools.getAssetImage(SsiAsset.iconUnSelect)),
                  ],
                ),
              ),
              index != widget.conditions!.length - 1
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: SsiLine())
                  : Container()
            ],
          ));
    }
  }
}
