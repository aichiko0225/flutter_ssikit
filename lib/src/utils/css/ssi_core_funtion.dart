import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ssikit/src/utils/css/ssi_util.dart';
import 'package:xml/xml_events.dart' as xml;

import '../../../flutter_ssikit.dart';

typedef SsiHyperLinkCallback = Function(String text, String url);

//用于将标签转为 style
class SsiConvert {
  //超链接的点击回调
  SsiHyperLinkCallback? _linkCallBack;

  //标签的集合
  Iterable<xml.XmlEvent> _eventList = [];

  //标签对应的style
  List<Tag> stack = [];

  //外部传入的默认文本样式
  TextStyle? _defaultStyle;

  SsiConvert(String cssContent,
      {SsiHyperLinkCallback? linkCallBack, TextStyle? defaultStyle}) {
    _eventList = xml.parseEvents(cssContent);
    _linkCallBack = linkCallBack;
    _defaultStyle = defaultStyle;
  }

  //转换的思路：将 开始标签 的属性转为 合适的style, 并将其存入集合中
  //                    font开始标签目前支持的属性：color、weight、size
  //                    a开始标签支持的属性：href
  //            文本标签 去获取style集合的最后一个元素 并应用style样式
  //            结束标签 则将集合的最后一个元素删除

  List<TextSpan> convert() {
    //优先使用外部提供的样式
    TextStyle style = _defaultStyle ??
        TextStyle(
          fontSize: 14,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.normal,
          color: SsiThemeConfigurator.instance
                  .getConfig()
                  ?.commonConfig
                  ?.colorTextImportant ??
              const Color(0xFF666666),
        );

    List<TextSpan> spans = [];
    for (var xmlEvent in _eventList) {
      if (xmlEvent is xml.XmlStartElementEvent) {
        if (!xmlEvent.isSelfClosing) {
          Tag tag = Tag();
          TextStyle textStyle = style.copyWith();
          if (xmlEvent.name == "font") {
            for (var attr in xmlEvent.attributes) {
              switch (attr.name) {
                case "color":
                  Color textColor =
                      SsiConvertUtil.generateColorByString(attr.value);
                  textStyle = textStyle.apply(color: textColor);
                  break;
                case "weight":
                  FontWeight fontWeight =
                      SsiConvertUtil.generateFontWidgetByString(attr.value);
                  textStyle = textStyle.apply(
                      fontWeightDelta:
                          fontWeight.index - FontWeight.normal.index);
                  break;
                case "size":
                  double size = SsiConvertUtil.generateFontSize(attr.value);
                  textStyle = textStyle.apply(fontSizeDelta: size - 13);
                  break;
              }
            }
            tag.isLink = false;
          }

          if (xmlEvent.name == "strong") {
            tag.isLink = false;
            textStyle = textStyle.apply(fontWeightDelta: 2);
          }

          if (xmlEvent.name == "a") {
            tag.isLink = true;
            for (var attr in xmlEvent.attributes) {
              switch (attr.name) {
                case "href":
                  textStyle = textStyle.apply(
                      color: SsiThemeConfigurator.instance
                          .getConfig()
                          ?.commonConfig
                          ?.brandPrimary);
                  tag.linkUrl = attr.value;
                  break;
              }
            }
          }
          tag.name = xmlEvent.name;
          tag.style = textStyle;
          stack.add(tag);
        } else {
          if (xmlEvent.name == "br") {
            spans.add(const TextSpan(text: "\n"));
          }
        }
      }

      if (xmlEvent is xml.XmlTextEvent) {
        Tag tag = Tag();
        tag.style = style.copyWith();
        if (stack.isNotEmpty) {
          tag = stack.last;
        }
        TextSpan textSpan = _createTextSpan(xmlEvent.text, tag);
        spans.add(textSpan);
      }

      if (xmlEvent is xml.XmlEndElementEvent) {
        Tag top = stack.removeLast();
        if (top.name != xmlEvent.name) {
          debugPrint("Error format  HTML");
        }
      }
    }

    return spans;
  }

  TextSpan _createTextSpan(String text, Tag tag) {
    if (text.isEmpty) return const TextSpan(text: "");
    TapGestureRecognizer tapGestureRecognizer = TapGestureRecognizer();
    tapGestureRecognizer.onTap = () {
      if (_linkCallBack != null) {
        _linkCallBack!(text, tag.linkUrl ?? "");
      }
    };
    return TextSpan(
        style: tag.style,
        text: text,
        recognizer: tag.isLink ? tapGestureRecognizer : null);
  }
}

class Tag {
  String? name;
  TextStyle? style;
  String? linkUrl;
  bool isLink = false;
}
