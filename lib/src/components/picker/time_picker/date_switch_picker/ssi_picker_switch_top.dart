import 'package:flutter_ssikit/src/components/picker/time_picker/date_switch_picker/ssi_datetime_switch_widget.dart';
import 'package:flutter_ssikit/src/theme/ssi_theme.dart';
import 'package:flutter_ssikit/src/utils/i18n/ssi_date_picker_i18n.dart';

import 'package:flutter/material.dart';

import '../ssi_date_picker_constants.dart';

/// DatePicker's title widget.

// ignore: must_be_immutable
class SsiPickerSwitchTop extends StatefulWidget {
  SsiPickerSwitchTop({
    Key? key,
    this.startMinTime,
    this.startMaxTime,
    this.currentStartTime,
    // this.endMinTime,
    // this.endMaxTime,
    this.currentEndTime,
    required this.maxTimeDifference,
    this.dateFormat = DATETIME_PICKER_TIME_FORMAT,
    this.locale = DATETIME_PICKER_LOCALE_DEFAULT,
    this.onChange,
    required this.onConfirm,
    this.minuteDivider = 1,
  }) : super(key: key) {
    DateTime minTime = startMinTime ?? DateTime.parse(DATE_PICKER_MIN_DATETIME);
    DateTime maxTime = startMaxTime ?? DateTime.parse(DATE_PICKER_MAX_DATETIME);
    assert(minTime.compareTo(maxTime) < 0);
  }

  final DateTime? startMinTime, startMaxTime, currentStartTime, currentEndTime;
  final int minuteDivider;
  final String? dateFormat;
  final DateTimePickerLocale locale;

  final DateValueCallback? onChange;
  final DateValueStartAndEndCallback? onConfirm;
  final int maxTimeDifference;

  @override
  State<StatefulWidget> createState() => _SSsiPickerSwitchTopState(
      startMinTime!, startMaxTime!, currentStartTime!, currentEndTime!);
}

class _SSsiPickerSwitchTopState extends State<SsiPickerSwitchTop> {
  DateTime _startMinTime, _startMaxTime, _currentStartTime, _currentEndTime;
  late DateTime _endMinTime, _endMaxTime;
  bool _isChooseStart = true;
  int type = 0;
  Widget? picker;
  late DateTime currentDateTime;

  _SSsiPickerSwitchTopState(
    this._startMinTime,
    this._startMaxTime,
    this._currentStartTime,
    this._currentEndTime,
  ) {
    _endMinTime = _startMinTime;
    _endMaxTime = _startMaxTime;
    currentDateTime = _currentEndTime;
  }

  @override
  Widget build(BuildContext context) {
    picker = getSsiDateTimeSwitchWidget();
    return GestureDetector(
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            topWidget(),
            getSsiDateTimeSwitchWidget(),
            queryWidget(),
          ],
        ),
      ),
    );
  }

  Widget topWidget() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (!_isChooseStart) {
                        _isChooseStart = !_isChooseStart;
                        type = 1;
                      }
                    });
                    //延时500毫秒执行
                    Future.delayed(const Duration(milliseconds: 100), () {
                      //延时执行的代码
                      setState(() {
                        //延时更新状态
                        type = 0;
                      });
                    });
                  },
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 9,
                      ),
                      Text(
                        "起始时间",
                        style: TextStyle(
                          fontSize: 12,
                          color:
                              Color(_isChooseStart ? 0xFF0050B3 : 0xFF272625),
                          fontWeight: _isChooseStart
                              ? FontWeight.w500
                              : FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      _isChooseStart
                          ? Container(
                              height: 2,
                              width: 54,
                              decoration: const BoxDecoration(
                                color: Color(0xFF0050B3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(1)),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      _onPressedEndTimeSwitch();
                      setState(() {
                        if (_isChooseStart) {
                          _isChooseStart = !_isChooseStart;
                          type = 0;
                        }
                      });
                      //延时500毫秒执行
                      Future.delayed(const Duration(milliseconds: 100), () {
                        //延时执行的代码
                        setState(() {
                          //延时更新状态
                          type = 1;
                        });
                      });
                    },
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 9,
                        ),
                        Text(
                          "终止时间",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(
                                !_isChooseStart ? 0xFF0050B3 : 0xFF272625),
                            fontWeight: !_isChooseStart
                                ? FontWeight.w500
                                : FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        !_isChooseStart
                            ? Container(
                                height: 2,
                                width: 54,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF0050B3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(1)),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  )),
            ],
          ),
          Container(
            height: 1,
            color: const Color(0xFFEAEDF2),
            margin: const EdgeInsets.only(left: 18, right: 18),
          )
        ],
      ),
    );
  }

  Widget getSsiDateTimeSwitchWidget() {
    return ((_isChooseStart && type == 0) || (!_isChooseStart && type == 1))
        ? SsiDateTimeSwitchWidget(
            minDateTime: _isChooseStart ? _startMinTime : _endMinTime,
            maxDateTime: _isChooseStart ? _startMaxTime : _endMaxTime,
            initDateTime: _isChooseStart ? _currentStartTime : _currentEndTime,
            dateFormat: widget.dateFormat,
            minuteDivider: widget.minuteDivider,
            locale: widget.locale,
            onChange: (dateTime, list) {
              currentDateTime = dateTime;
              if (_isChooseStart) {
                _currentStartTime = dateTime;
              } else {
                _currentEndTime = dateTime;
              }
              widget.onChange!(dateTime, list);
            },
          )
        : Container(
            height: 150,
            color: Colors.white,
          );
  }

  Widget queryWidget() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 17, right: 17, top: 20, bottom: 20),
      child: InkWell(
        onTap: () {
          widget.onConfirm!(_currentStartTime, _currentEndTime);
          Navigator.pop(context);
        },
        child: Container(
          height: 40,
          decoration: const BoxDecoration(
            color: Color(0xFF0050B3),
            borderRadius: BorderRadius.all(Radius.circular(5.22)),
          ),
          child: const Center(
            child: Text(
              "查询",
              style: TextStyle(
                fontSize: 15.6,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///切换为结束时间
  void _onPressedEndTimeSwitch() {
    _endMinTime = _currentStartTime;
    if (DateTime.now().millisecondsSinceEpoch -
            _currentStartTime.millisecondsSinceEpoch >
        widget.maxTimeDifference) {
      _endMaxTime = DateTime.fromMillisecondsSinceEpoch(
          _currentStartTime.millisecondsSinceEpoch + widget.maxTimeDifference);
    } else {
      _endMaxTime = DateTime.now();
    }
    if (_currentEndTime.millisecondsSinceEpoch <
            _endMinTime.millisecondsSinceEpoch ||
        _currentEndTime.millisecondsSinceEpoch >
            _endMaxTime.millisecondsSinceEpoch) {
      _currentEndTime = _endMaxTime;
    }
  }
}
