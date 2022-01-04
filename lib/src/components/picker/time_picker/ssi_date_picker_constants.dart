/// Selected value of DatePicker.
// ignore_for_file: constant_identifier_names

typedef DateValueCallback = Function(DateTime dateTime, List<int> selectedIndex);

typedef DateRangeValueCallback = Function(DateTime startDateTime, DateTime endDateTime,
    List<int> startSelectedIndex, List<int> endSelectedIndex);

typedef DateRangeSideValueCallback = Function(DateTime selectDateTime, List<int> selectedIndex);

/// Pressed cancel callback.
typedef DateVoidCallback = void Function();

/// Default value of minimum datetime.
const String DATE_PICKER_MIN_DATETIME = "1900-01-01 00:00:00";

/// Default value of maximum datetime.
const String DATE_PICKER_MAX_DATETIME = "2100-12-31 23:59:59";

/// Default value of date format
const String DATETIME_PICKER_DATE_FORMAT = 'yyyy-MM-dd';

/// Default value of time format
const String DATETIME_PICKER_TIME_FORMAT = 'HH:mm:ss';

/// Default value of datetime format
const String DATETIME_PICKER_DATETIME_FORMAT = 'yyyy-MM-dd HH:mm:ss';

/// Default value of date format
const String DATETIME_RANGE_PICKER_DATE_FORMAT = 'MM-dd';

/// Default value of time format
const String DATETIME_RANGE_PICKER_TIME_FORMAT = 'HH:mm';

/// Default value of datetime format
const String DATETIME_RANGE_PICKER_DATETIME_FORMAT = 'MMdd HH:mm';
