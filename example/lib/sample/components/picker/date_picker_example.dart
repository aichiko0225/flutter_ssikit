import 'package:flutter/material.dart';
import 'package:flutter_ssikit/flutter_ssikit.dart';
import 'package:flutter_ssikit_example/sample/home/list_item.dart';

class DatePickerExamplePage extends StatelessWidget {
  final String _title;

  DatePickerExamplePage(this._title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: ListView(
          children: <Widget>[
            ListItem(
              title: "TimeStyle",
              describe: '时间样式选择器',
              onPressed: () {
                _showPicker(context, SsiDateTimePickerMode.time);
              },
            ),
            ListItem(
              title: "DateStyle",
              describe: '日期样式时间选择器',
              onPressed: () {
                _showPicker(context, SsiDateTimePickerMode.date);
              },
            ),
            ListItem(
              title: "DateAndTimeStyle",
              describe: '日期和时间样式选择器',
              onPressed: () {
                _showPicker(context, SsiDateTimePickerMode.datetime);
              },
            ),
            ListItem(
              title: "DateAndTimeStyle",
              describe: '日期和时间样式开始时间结束时间切换选择器',
              onPressed: () {
                _showSwitchPicker(
                    context, SsiDateTimeSwitchPickerMode.datetime);
              },
            ),
          ],
        ));
  }

//  ///时间样式时间选择器
//  void _showTimeStyle(BuildContext context) {
//    DatePickerWidget(
//      context: context,
//      title: "请选择开始看房时间",
//      mode: CupertinoDatePickerMode.time,
//      minuteInterval: 20,
//      currentDate: DateTime.now(),
//      confirmTimeClick: (date) {
//        print("the date is ${date.toString()}");
//      },
//    ).show();
//  }
//
//  ///日期样式选择器
//  void _showDateStyle(BuildContext context) {
//    DatePickerWidget(
//      context: context,
//      title: "请选择入住时间",
//      mode: CupertinoDatePickerMode.date,
//      minYear: 2019,
//      currentDate: DateTime.now(),
//      confirmTimeClick: (date) {
//        print("the date is ${date.toString()}");
//      },
//    ).show();
//  }
//
//  ///日期和时间样式选择器
//  void _showDateAndTimeStyle(BuildContext context) {
//    DatePickerWidget(
//      context: context,
//      title: "请选择入住时间",
//      mode: CupertinoDatePickerMode.dateAndTime,
//      minDate: DateTime.now(),
//      currentDate: DateTime.now(),
//      confirmTimeClick: (date) {
//        print("the date is ${date.toString()}");
//      },
//    ).show();
//  }

  _showPicker(BuildContext context, SsiDateTimePickerMode mode) {
    String format = 'yyyy-MMMM-dd';
    const String MIN_DATETIME = '2020-01-15 00:00:00';
    const String MAX_DATETIME = '2021-12-31 23:59:59';
    switch (mode) {
      case SsiDateTimePickerMode.date:
        format = 'yyyy年,MMMM月,dd日';
        break;
      case SsiDateTimePickerMode.datetime:
        format = 'yyyy年,MM月,dd日,HH时:mm分:ss秒';
        break;
      case SsiDateTimePickerMode.time:
        format = 'HH:mm:ss';
        break;
      default:
        format = 'yyyy-MMMM-dd';
        break;
    }

    SsiDatePicker.showDatePicker(context,
        maxDateTime: DateTime.parse(MAX_DATETIME),
        minDateTime: DateTime.parse(MIN_DATETIME),
        initialDateTime: DateTime.parse('2020-01-01 18:26:59'),
        pickerMode: mode,
        minuteDivider: 1,
        pickerTitleConfig: SsiPickerTitleConfig.defaultConfig,
        dateFormat: format, onConfirm: (dateTime, list) {
      SsiToast.show("onConfirm:  $dateTime   $list", context);
    }, onClose: () {
      print("onClose");
    }, onCancel: () {
      print("onCancel");
    }, onChange: (dateTime, list) {
      print("onChange:  $dateTime    $list");
    });
  }

  _showSwitchPicker(BuildContext context, SsiDateTimeSwitchPickerMode mode) {
    String format = 'yyyy-MMMM-dd';
    const String MIN_DATETIME = '2020-01-15 00:00:00';
    switch (mode) {
      case SsiDateTimeSwitchPickerMode.date:
        format = 'yyyy年,MMMM月,dd日';
        break;
      case SsiDateTimeSwitchPickerMode.datetime:
        format = 'yyyy年,MM月,dd日,HH时:mm分';
        break;
      case SsiDateTimeSwitchPickerMode.time:
        format = 'HH:mm:ss';
        break;
      default:
        format = 'yyyy-MMMM-dd';
        break;
    }

    SsiDateSwitchPicker.showDatePicker(context,
        maxDateTime: DateTime.now(),
        minDateTime: DateTime.parse(MIN_DATETIME),
        initialStartDateTime: DateTime.now(),
        initialEndDateTime: DateTime.now(),
        pickerMode: mode,
        minuteDivider: 1,
        pickerTitleConfig: SsiPickerTitleConfig.defaultConfig,
        dateFormat: format, onConfirm: (startDateTime, endDateTime) {
          print("startDateTime:  $startDateTime    $endDateTime");
          SsiToast.show("onConfirm:  $startDateTime   $endDateTime", context);
    }, onClose: () {
      print("onClose");
    }, onCancel: () {
      print("onCancel");
    }, onChange: (dateTime, list) {
      print("onChange:  $dateTime    $list");
    });
  }
}
