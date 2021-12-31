import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ssikit/src/theme/ssi_theme.dart';

import 'base/ssi_form_item_type.dart';
import 'utils/ssi_form_util.dart';

///
/// 文本输入型录入项
///
/// 包括"标题"、"副标题"、"错误信息提示"、"必填项提示"、"添加/删除按钮"、"消息提示"、
/// "文本输入框"等元素
///
// ignore: must_be_immutable
class SsiTextInputFormItem extends StatefulWidget {
  /// 录入项的唯一标识，主要用于录入类型页面框架中
  final String? label;

  /// 录入项类型，主要用于录入类型页面框架中
  String type = SsiInputItemType.TEXT_INPUT_TYPE;

  /// 录入项标题
  final String title;

  /// 录入项子标题
  final String? subTitle;

  /// 录入项提示（问号图标&文案） 用户点击时触发onTip回调。
  /// 1. 若赋值为 空字符串（""）时仅展示"问号"图标，
  /// 2. 若赋值为非空字符串时 展示"问号图标&文案"，
  /// 3. 若不赋值或赋值为null时 不显示提示项
  /// 默认值为 3
  final String? tipLabel;

  /// 录入项前缀图标样式 "添加项" "删除项" 详见 [SsiPrefixIconType] 类
  final String prefixIconType;

  /// 录入项错误提示
  final String error;

  /// 录入项是否为必填项（展示*图标） 默认为 false 不必填
  final bool isRequire;

  /// 录入项 是否可编辑
  /// 默认值: true
  final bool isEdit;

  /// 录入项不可编辑时(isEdit: false) "+"、"-"号是否可点击
  /// true: 可点击回调 false: 不可点击回调
  /// 默认值: false
  final bool isPrefixIconEnabled;

  /// 点击"+"图标回调
  final VoidCallback? onAddTap;

  /// 点击"-"图标回调
  final VoidCallback? onRemoveTap;

  /// 点击"？"图标回调
  final VoidCallback? onTip;

  /// 固定内容
  final String? prefixText;

  /// 提示文案
  final String hint;

  /// 单位, 输入框后面的单位 可为null
  final String? unit;

  /// 输入内容类型
  final String inputType;

  /// 最大可输入字符数
  final int? maxCharCount;

  List<TextInputFormatter>? inputFormatters;

  /// 输入变化回调
  final ValueChanged<String>? onChanged;

  final TextEditingController? controller;

  /// form配置
  SsiFormItemConfig? themeData;

  SsiTextInputFormItem({
    Key? key,
    this.label,
    this.type = SsiInputItemType.TEXT_INPUT_TYPE,
    this.title = "",
    this.subTitle,
    this.tipLabel,
    this.prefixIconType = SsiPrefixIconType.TYPE_NORMAL,
    this.error = "",
    this.isEdit = true,
    this.isRequire = false,
    this.isPrefixIconEnabled = false,
    this.onAddTap,
    this.onRemoveTap,
    this.onTip,
    this.prefixText,
    this.hint = "请输入",
    this.unit,
    this.maxCharCount,
    this.inputType = SsiInputType.text,
    this.inputFormatters,
    this.onChanged,
    this.controller,
    this.themeData,
  }) : super(key: key) {
    themeData = SsiThemeConfigurator.instance
        .getConfig()
        ?.formItemConfig
        ?.merge(themeData);
  }

  @override
  State<StatefulWidget> createState() {
    return SsiTextInputFormItemState();
  }
}

class SsiTextInputFormItemState extends State<SsiTextInputFormItem> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: SsiFormUtil.itemEdgeInsets(widget.themeData),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 25,
            ),
            child: Row(
              children: <Widget>[
                Container(
                  padding: SsiFormUtil.titleEdgeInsets(widget.prefixIconType,
                      widget.isRequire, widget.themeData),
                  child: Row(
                    children: <Widget>[
                      SsiFormUtil.buildPrefixIcon(
                          widget.prefixIconType,
                          widget.isEdit,
                          context,
                          widget.onAddTap,
                          widget.onRemoveTap),
                      SsiFormUtil.buildRequireWidget(widget.isRequire),
                      SsiFormUtil.buildTitleWidget(
                          widget.title, widget.themeData),
                      Offstage(
                        offstage: (widget.prefixText == null),
                        child: Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              widget.prefixText ?? "",
                              style: SsiFormUtil.getTitleTextStyle(
                                  widget.themeData),
                            )),
                      ),
                      SsiFormUtil.buildTipLabelWidget(
                          widget.tipLabel, widget.onTip, widget.themeData),
                    ],
                  ),
                ),
                Expanded(
                  child: TextField(
                    keyboardType: SsiFormUtil.getInputType(widget.inputType),
                    enabled: widget.isEdit,
                    maxLines: 1,
                    maxLength: widget.maxCharCount,
                    style: SsiFormUtil.getIsEditTextStyle(
                        widget.themeData, widget.isEdit),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: SsiFormUtil.getHintTextStyle(widget.themeData),
                      hintText: widget.hint,
                      counterText: "",
                      contentPadding: EdgeInsets.all(0),
                      isDense: true,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                    ),
                    textAlign: TextAlign.end,
                    controller: _controller,
                    inputFormatters: widget.inputFormatters,
                    onChanged: (text) {
                      SsiFormUtil.notifyInputChanged(widget.onChanged, text);
                    },
                  ),
                ),
                Offstage(
                  offstage: (widget.unit == null),
                  child: Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        widget.unit ?? "",
                        style: TextStyle(
                          color: Color(0xFF101010),
                          fontSize: 16,
                        ),
                      )),
                ),
              ],
            ),
          ),
          SsiFormUtil.buildSubTitleWidget(widget.subTitle, widget.themeData),
          SsiFormUtil.buildErrorWidget(widget.error, widget.themeData)
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    // 如果controller由外部创建不需要销毁, 若由内部创建则需要销毁
    if (widget.controller != null) {
      _controller.dispose();
    }
  }
}
