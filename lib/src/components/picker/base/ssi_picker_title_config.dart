import 'ssi_picker_constants.dart';
import 'package:flutter/material.dart';

class SsiPickerTitleConfig {
  final Text cancelDefault = const Text('OK');

  /// DateTimePicker theme.
  ///
  /// [cancel] Custom cancel widget.
  /// [confirm] Custom confirm widget.
  /// [title] Custom title widget. If specify a title widget, the cancel and confirm widgets will not display. Must set [titleHeight] value for custom title widget.
  /// [showTitle] Whether display title widget or not. If set false, the default cancel and confirm widgets will not display, but the custom title widget will display if had specified one custom title widget.
  /// [titleContent] Title content
  const SsiPickerTitleConfig({
    this.cancel,
    this.confirm,
    this.title,
    this.showTitle = PICKER_SHOW_TITLE_DEFAULT,
    this.titleContent = "请选择",
  });

  static const SsiPickerTitleConfig defaultConfig = SsiPickerTitleConfig();

  /// Custom cancel [Widget].
  final Widget? cancel;

  /// Custom confirm [Widget].
  final Widget? confirm;

  /// Custom title [Widget]. If specify a title widget, the cancel and confirm widgets will not display.
  final Widget? title;

  /// Whether display title widget or not. If set false, the default cancel and confirm widgets will not display, but the custom title widget will display if had specified one custom title widget.
  final bool showTitle;

  final String titleContent;
}
