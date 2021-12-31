
/// 用于model兼容回调
/// 主要用于各种点击事件
typedef SsiFormSelectAll = void Function(int index, bool isSelect);

/// 主要用于各种输入值变化
typedef SsiFormRadioValueChanged = void Function(String oldStr, String newStr);
typedef SsiFormSwitchChanged = void Function(bool oldValue, bool newValue);
typedef SsiFormValueChanged = void Function(int oldValue, int newValue);
typedef SsiFormMultiChoiceValueChanged = void Function(List<String> oldValue, List<String> newValue);
typedef SsiFormBtnSelectChanged = void Function(List<bool> oldValue, List<bool> newValue);

/// 用于model兼容回调 定义等同于 form_interface
/// 主要用于各种点击事件
typedef SsiFormTitleSelected = void Function(String title, int index);

