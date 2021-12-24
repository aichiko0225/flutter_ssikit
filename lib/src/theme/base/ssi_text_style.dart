import 'package:flutter/material.dart';

///  TextStyle处理类  用来将内部属性重新赋值进行copyWith 和 merge操作
class SsiTextStyle {

  Color? color;
  double? fontSize;
  FontWeight? fontWeight;
  TextDecoration? decoration;
  double? height;
  TextBaseline? textBaseline;

  SsiTextStyle({
    this.color,
    this.fontSize,
    this.fontWeight,
    this.decoration,
    this.textBaseline,
    this.height,
  });

  SsiTextStyle.withStyle(TextStyle? style) {
    if (style == null) {
      return;
    }
    if (style.color != null) {
      color = style.color;
    }
    if (style.fontSize != null) {
      fontSize = style.fontSize;
    }
    if (style.fontWeight != null) {
      fontWeight = style.fontWeight;
    }
    if (style.decoration != null) {
      decoration = style.decoration;
    }
    if (style.height != null) {
      height = style.height;
    }
    if (style.textBaseline != null) {
      textBaseline = style.textBaseline;
    }
  }

  TextStyle generateTextStyle() {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: decoration ?? TextDecoration.none,
      height: height,
      textBaseline: textBaseline,
    );
  }

  void flatTextStyle(SsiTextStyle? defaultTextStyle) {
    if (defaultTextStyle == null) {
      return;
    }
    if (defaultTextStyle.color != null) {
      color ??= defaultTextStyle.color;
    }
    if (defaultTextStyle.fontSize != null) {
      fontSize ??= defaultTextStyle.fontSize;
    }
    if (defaultTextStyle.fontWeight != null) {
      fontWeight ??= defaultTextStyle.fontWeight;
    }
    if (defaultTextStyle.decoration != null) {
      decoration ??= defaultTextStyle.decoration;
    }
    if (defaultTextStyle.height != null) {
      height ??= defaultTextStyle.height;
    }
    if (defaultTextStyle.textBaseline != null) {
      textBaseline ??= defaultTextStyle.textBaseline;
    }
  }

  SsiTextStyle copyWith(
      {Color? color,
      double? fontSize,
      FontWeight? fontWeight,
      TextDecoration? decoration,
      double? height,
      TextBaseline? textBaseline}) {
    return SsiTextStyle(
      color: color ?? this.color,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      decoration: decoration ?? this.decoration,
      height: height ?? this.height,
      textBaseline: textBaseline ?? this.textBaseline,
    );
  }

  SsiTextStyle merge(SsiTextStyle? other) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      fontSize: other.fontSize,
      fontWeight: other.fontWeight,
      decoration: other.decoration,
      height: other.height,
      textBaseline: other.textBaseline,
    );
  }
}
