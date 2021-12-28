import 'dart:ui';

import '../../theme/ssi_theme_configurator.dart';

import '../../theme/base/ssi_text_style.dart';
import '../../theme/configs/ssi_common_config.dart';

import 'package:flutter/material.dart';

typedef SsiCommonActionSheetItemClickCallBack = void Function(
    int index, SsiCommonActionSheetItem actionItem);
typedef SsiCommonActionSheetItemClickInterceptor = bool Function(
    int index, SsiCommonActionSheetItem actionItem);

/// 每行样式
enum SsiCommonActionSheetItemStyle {
  /// 默认样式
  normal,

  /// 链接样式，颜色使用主题色号[SsiCommonConfig.brandPrimary]
  link,

  /// 警示项 ，颜色使用[SsiCommonConfig.brandError]
  alert,
}

class SsiCommonActionSheetItem {
  /// 标题文字
  String title;

  /// 辅助信息
  String? desc;

  /// 样式 [SsiActionSheetActionStyle]
  final SsiCommonActionSheetItemStyle actionStyle;

  /// 主标题文本样式
  final TextStyle? titleStyle;

  /// 辅助信息文本样式
  final TextStyle? descStyle;

  SsiCommonActionSheetItem(
    this.title, {
    this.desc,
    this.actionStyle = SsiCommonActionSheetItemStyle.normal,
    this.titleStyle,
    this.descStyle,
  });
}

/// 吸底列表弹框，可自定义标题文案
/// 可通过配置[SsiCommonActionSheetItemStyle]来设定 item 的样式
// ignore: must_be_immutable
class SsiCommonActionSheet extends StatelessWidget {
  /// 每个选项相关的配置信息的列表
  /// 每个选项支持修改内容见[SsiCommonActionSheetItem]
  final List<SsiCommonActionSheetItem> actions;

  /// ActionSheet 标题
  final String? title;

  /// title区域widget, 与 title 字段互斥，当 titleWidget 不为 null 时优先使用 titleWidget。
  final Widget? titleWidget;

  /// Action 之间分割线颜色，默认值 Color(0xfff0f0f0)
  final Color separatorLineColor;

  /// 取消按钮与 Action 之间的分割线的颜色，默认值 Color(0xfff8f8f8)
  final Color spaceColor;

  /// 取消按钮文本
  final String? cancelTitle;

  /// 标题最大行数，默认为2
  final int maxTitleLines;

  /// 列表最大高度限制，默认为屏幕高度减去上下安全距离
  /// 默认为0
  final double maxSheetHeight;

  /// Action Item 的点击事件
  final SsiCommonActionSheetItemClickCallBack? clickCallBack;

  /// Action Item 点击事件拦截回调
  final SsiCommonActionSheetItemClickInterceptor? onItemClickInterceptor;

  /// 下面的属性为配置性的属性，暂时去除配置性的功能

  /// ActionSheet 的顶部圆角
  /// default value is 8.0
  final double _topRadius = 8.0;

  /// 内容左右间距
  /// default value is EdgeInsets.only(top: 12, bottom: 12, left: 60, right: 60)
  final EdgeInsets _contentPadding =
      const EdgeInsets.only(top: 12, bottom: 12, left: 60, right: 60);

  /// title 左右间距
  ///default value is EdgeInsets.only(top: 16, bottom: 16, left: 60, right: 60)
  final EdgeInsets _titlePadding =
      const EdgeInsets.only(top: 16, bottom: 16, left: 60, right: 60);

  static final SsiCommonConfig? _commonConfig =
      SsiThemeConfigurator.instance.getConfig()?.commonConfig;

  /// 标题样式
  /// default value is TextStyle(color:[SsiCommonConfig.colorTextSecondary],fontSize:[SsiCommonConfig.fontSizeBase])
  final SsiTextStyle _titleStyle = SsiTextStyle(
      fontSize: _commonConfig?.fontSizeBase,
      color: _commonConfig?.colorTextSecondary);

  /// 取消按钮样式
  /// default value is TextStyle(color:[SsiCommonConfig.colorTextBase],fontSize:[SsiCommonConfig.fontSizeSubHead],fontWeight: FontWeight.w600)
  final SsiTextStyle _cancelStyle = SsiTextStyle(
      fontSize: _commonConfig?.fontSizeSubHead,
      color: _commonConfig?.colorTextBase);

  /// 元素标题默认样式
  /// default value is TextStyle(color:[SsiCommonConfig.colorTextBase],fontSize:[SsiCommonConfig.fontSizeSubHead])
  final SsiTextStyle _itemTitleStyle = SsiTextStyle(
      fontSize: _commonConfig?.fontSizeSubHead,
      color: _commonConfig?.colorTextBase);

  /// 元素标题链接样式
  /// default value is TextStyle(color:[SsiCommonConfig.colorLink],fontSize:[SsiCommonConfig.fontSizeSubHead],fontWeight: FontWeight.w600)
  final SsiTextStyle _itemTitleStyleLink = SsiTextStyle(
      fontSize: _commonConfig?.fontSizeSubHead,
      color: _commonConfig?.colorLink);

  /// 元素警示项标题样式
  /// default value is TextStyle(color:[SsiCommonConfig.brandError],fontSize:[SsiCommonConfig.fontSizeBase],fontWeight: FontWeight.w600)
  final SsiTextStyle _itemTitleStyleAlert = SsiTextStyle(
      fontSize: _commonConfig?.fontSizeBase, color: _commonConfig?.brandError);

  /// 元素描述默认样式
  /// default value is TextStyle(color:[SsiCommonConfig.colorTextBase],fontSize:[SsiCommonConfig.fontSizeCaption],fontWeight: FontWeight.w600)
  final SsiTextStyle _itemDescStyle = SsiTextStyle(
      fontSize: _commonConfig?.fontSizeCaption,
      color: _commonConfig?.colorTextBase);

  /// 元素标题描述链接样式
  /// default value is TextStyle(color:[SsiCommonConfig.colorLink],fontSize:[SsiCommonConfig.fontSizeCaption],fontWeight: FontWeight.w600)
  final SsiTextStyle _itemDescStyleLink = SsiTextStyle(
      fontSize: _commonConfig?.fontSizeCaption,
      color: _commonConfig?.colorLink);

  /// 元素警示项标题描述样式
  /// default value is TextStyle(color:[SsiCommonConfig.brandError],fontSize:[SsiCommonConfig.fontSizeCaption],fontWeight: FontWeight.w600)
  final SsiTextStyle _itemDescStyleAlert = SsiTextStyle(
      fontSize: _commonConfig?.fontSizeCaption,
      color: _commonConfig?.brandError);

  SsiCommonActionSheet({
    Key? key,
    required this.actions,
    this.title,
    this.titleWidget,
    this.cancelTitle,
    this.clickCallBack,
    this.separatorLineColor = const Color(0xfff0f0f0),
    this.spaceColor = const Color(0xfff8f8f8),
    this.maxTitleLines = 2,
    this.maxSheetHeight = 0,
    this.onItemClickInterceptor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EdgeInsets padding = MediaQueryData.fromWindow(window).padding;
    double maxHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;

    double _maxSheetHeight = 0;

    if (maxSheetHeight <= 0 || maxSheetHeight > maxHeight) {
      _maxSheetHeight = maxHeight;
    }
    return GestureDetector(
      child: Container(
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(_topRadius),
                topRight: Radius.circular(_topRadius),
              ),
            ),
          ),
          child:
              SafeArea(child: _configActionWidgets(context, _maxSheetHeight))),
      onVerticalDragUpdate: (v) => {},
    );
  }

  /// 构建actionSheet的按钮
  Widget _configActionWidgets(BuildContext context, double _maxSheetHeight) {
    List<Widget> widgets = [];
    // 构建整体标题
    if (titleWidget != null) {
      // 如果传入了则直接使用
      widgets.add(titleWidget!);
    } else if (title != null && title.toString().trim() != "") {
      // 如果只传入title则根据文案构建默认title
      widgets.add(_configTitleActions());
    }
    widgets.add(_configListActions(context));
    // 添加间隔
    widgets.add(Divider(
      color: spaceColor,
      thickness: 8,
      height: 8,
    ));
    widgets.add(_configCancelAction(context));

    return Container(
      constraints: BoxConstraints(maxHeight: _maxSheetHeight),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: widgets,
      ),
    );
  }

  /// 构建标题widget
  Widget _configTitleActions() {
    // 构建整体标题
    return Column(
      children: <Widget>[
        Container(
          padding: _titlePadding,
          child: Center(
            child: Text(
              title ?? '',
              textAlign: TextAlign.center,
              maxLines: maxTitleLines,
              style: _titleStyle.generateTextStyle(),
            ),
          ),
        ),
        Divider(
          //有标题则添加分割线
          thickness: 1,
          height: 1,
          color: separatorLineColor,
        ),
      ],
    );
  }

  /// 构建列表widget
  Widget _configListActions(BuildContext context) {
    List<Widget> tiles = [];
    //构建列表内容
    for (int index = 0; index < actions.length; index++) {
      tiles.add(
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: _contentPadding,
            child: _configTile(actions[index]),
          ),
          onTap: () {
            if (onItemClickInterceptor == null ||
            (onItemClickInterceptor != null && !onItemClickInterceptor!(index, actions[index]))) {
              // 推荐使用回调方法处理点击事件!!!!!!!!!!
              if (clickCallBack != null) {
                clickCallBack!(index, actions[index]);
              }
              // 如果未拦截，则pop掉当前页面，并且携带信息（不建议使用此信息进行点击时间处理）
              Navigator.of(context).pop([index, actions[index]]);
            }
          },
        ),
      );
      tiles.add(Divider(
        thickness: 1,
        height: 1,
        color: separatorLineColor,
      ));
    }
    return Flexible(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: tiles,
      ),
    );
  }

  // 配置每个选项内部信息
  // action 每个item配置项 [SsiCommonActionSheetItem]
  Widget _configTile(SsiCommonActionSheetItem action) {
    List<Widget> tileElements = [];
    bool hasTitle = false;
    // 如果有标题则添加标题
    if (action.title != null) {
      tileElements.add(Center(
        child: Text(
          action.title,
          maxLines: 1,
          style: action.titleStyle ??
              (action.actionStyle == SsiCommonActionSheetItemStyle.alert
                  ? _itemTitleStyleAlert.generateTextStyle()
                  : (action.actionStyle == SsiCommonActionSheetItemStyle.link
                      ? _itemTitleStyleLink.generateTextStyle()
                      : _itemTitleStyle.generateTextStyle())),
        ),
      ));
      hasTitle = true;
    }
    // 如果有辅助信息则添加辅助信息
    if (action.desc != null) {
      // 如果有标题添加间距
      if (hasTitle) {
        tileElements.add(const SizedBox(
          height: 2,
        ));
      }
      tileElements.add(
        Center(
          child: Text(
            action.desc ?? '',
            textAlign: TextAlign.center,
            maxLines: 1,
            style: action.descStyle ??
                (action.actionStyle == SsiCommonActionSheetItemStyle.alert
                    ? _itemDescStyleAlert.generateTextStyle()
                    : (action.actionStyle == SsiCommonActionSheetItemStyle.link
                        ? _itemDescStyleLink.generateTextStyle()
                        : _itemDescStyle.generateTextStyle())),
          ),
        ),
      );
    }
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: tileElements),
    );
  }

  /// 构建取消操作按钮
  Widget _configCancelAction(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        color: Color(0xffffffff),
        padding: EdgeInsets.only(top: 12, bottom: 12),
        child: Center(
          child: Text(
            cancelTitle ?? "取消",
            style: _cancelStyle.generateTextStyle(),
          ),
        ),
      ),
    );
  }
}
