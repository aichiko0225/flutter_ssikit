// ignore_for_file: constant_identifier_names

/// 额外的icon 类型 普通、添加、删除
class SsiPrefixIconType {
  static const String TYPE_NORMAL = "type_normal";
  static const String TYPE_ADD = "type_add";
  static const String TYPE_REMOVE = "type_remove";
}

/// 用于描述表单项的类型
class SsiInputItemType {
  /// appbar 类型
  static const String HEADER_NORMAL_TYPE = "header_normal_type";

  /// 表单项类型
  static const String TEXT_INPUT_TYPE = "text_input_type";
  static const String TEXT_FORMAT_INPUT_TYPE = "text_format_input_type";
  static const String TEXT_ARRAY_INPUT_TYPE = "text_array_input_type";
  static const String TEXT_SELECT_INPUT_TYPE = "text_select_input_type";
  static const String TEXT_BLOCK_INPUT_TYPE = "text_block_input_type";
  static const String TEXT_INPUT_TITLE_SELECT_TYPE = "text_input_title_select_type";
  static const String TEXT_RANGE_INPUT_TYPE = "text_range_input_type";
  static const String TEXT_STEP_INPUT_TYPE = "text_step_input_type";
  static const String RADIO_INPUT_TYPE = "radio_input_type";
  static const String RADIO_PORTRAIT_INPUT_TYPE = "radio_column_input_type";
  static const String MULTI_CHOICE_INPUT_TYPE = "multi_choice_input_type";
  static const String MULTI_CHOICE_PORTRAIT_INPUT_TYPE = "multi_choice_column_input_type";
  static const String SWITCH_TYPE = "switch_type";

  static const String STAR_INPUT_TYPE = "star_input_type";
  static const String PHOTO_PICKER_TYPE = "photo_picker_type";
  static const String EXPAND_GROUP_TYPE = "expand_group_type";
  static const String NORMAL_GROUP_TYPE = "normal_group_type";
  static const String TEXT_INPUT_RATIO_TYPE = "text_input_ratio_type";

  static const String TEXT_QUICK_SELECT_INPUT_TYPE = "text_quick_select_input_type";

  /// bottom类型
  static const String BOTTOM_BTN_TYPE = "bottom_btn_type";

  static const String BTN_TYPE = "btn_type";
  static const String BTN_MULTI_TYPE = "btn_multi_type";
  static const String BTN_MULTI_STATE_TYPE = "btn_multi_state_type";

  static const String LABEL_TITLE = "label_title";
  static const String LABEL_ADD = "label_add";

}

/// 键盘类型
class SsiInputType {
  static const String text = "text";
  static const String multi_line = "multiline";
  static const String number = "number";
  static const String decimal = "decimal";
  static const String phone = "phone";
  static const String date = "datetime";
  static const String email = "emailAddress";
  static const String url = "url";
  static const String password = "visiblePassword";
}
