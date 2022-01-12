import 'dart:ffi';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ssikit/flutter_ssikit.dart';
import "package:intl/intl.dart";

class BrokenLineExamplePage extends StatefulWidget {
  @override
  _BrokenLineExamplePageState createState() => _BrokenLineExamplePageState();
}

class _BrokenLineExamplePageState extends State<BrokenLineExamplePage> {
  List<String> xAisList = [];

  // List<double> yAisList = [];
  List<double> y1List = [];
  List<double> y2List = [];

  Color color1 = const Color(0xFFA7CC3D);
  Color color2 = const Color(0xFF5DDBD3);

  @override
  void initState() {
    super.initState();
    xAisList.add("09/01");
    xAisList.add("09/05");
    xAisList.add("09/10");
    xAisList.add("09/15");
    xAisList.add("09/20");
    xAisList.add("09/25");
    xAisList.add("09/30");

    y1List.add(0);
    y1List.add(3);
    y1List.add(2);
    y1List.add(1);
    y1List.add(6);
    y1List.add(2);
    y1List.add(3);

    y2List.add(9);
    y2List.add(89);
    y2List.add(66);
    y2List.add(29.9);
    y2List.add(50);
    y2List.add(14);
    y2List.add(38);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('运营统计'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(5)),
            _brokenLineExample1(context),
            const Padding(padding: EdgeInsets.all(5)),
            _brokenLineExample2(context),
            const Padding(padding: EdgeInsets.all(25)),
          ],
        ),
      ),
    );
  }

  ////////////////////////////
  Widget _brokenLineExample1(context) {
    var chartLine = SsiBrokenLine(
      isTipWindowAutoDismiss: false,
      lines: _linesForExample1(),
      size: Size(MediaQuery.of(context).size.width - 80,
          MediaQuery.of(context).size.height / 5 * 1.6 - 20 * 2),
      isShowXHintLine: true,
      yHintLineOffset: 20,
      yDialValues: _yDialValuesForExample1(_getMaxValueForExample1(y1List) / 5),
      yDialMin: 0,
      yDialMax: _getMaxValueForExample1(y1List),
      xDialValues: _xDialValuesForExample1(xAisList),
      xDialMin: 1,
      xDialMax: 7,
      isHintLineSolid: false,
      isShowYDialText: true,
    );
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 14,
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsetsDirectional.only(start: 15, top: 4),
                width: 4,
                height: 16,
                decoration: BoxDecoration(
                  color: const Color(0xFF0050B3),
                  borderRadius: BorderRadius.circular((1.0)),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text('折线图',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF333333),
                      fontWeight: FontWeight.bold)),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: chartLine,
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }

  List<SsiPointsLine> _linesForExample1() {
    SsiPointsLine _pointsLine;
    List<SsiPointsLine> pointsLineList = [];
    _pointsLine = SsiPointsLine(
      isShowPointText: false,
      isShowXDial: true,
      lineWidth: 3,
      pointRadius: 4,
      isShowPoint: true,
      isCurve: false,
      points: _setSsiPointDataList(y1List, color1),
      shaderColors: [color1.withOpacity(0.3), color1.withOpacity(0.01)],
      lineColor: color1,
    );

    pointsLineList.add(_pointsLine);
    return pointsLineList;
  }

  double _getMinValueForExample1(List<double> list) {
    if (list.isEmpty) {
      return 0;
    }
    double minValue = list[0];
    for (double point in list) {
      minValue = min(point, minValue);
    }
    return minValue;
  }

  double _getMaxValueForExample1(List<double> list) {
    if (list.isEmpty) {
      return 0;
    }
    double maxValue = list[0];
    for (double point in list) {
      maxValue = max(point, maxValue);
    }
    int maxValue2 = ((maxValue / 10).toInt() + 1) * 10;

    if (maxValue <= 12) {
      return maxValue;
    } else {
      if (maxValue2 / 5 * 4 >= maxValue && maxValue2 - 5 > maxValue) {
        maxValue2 = maxValue2 - 5;
      }
    }
    return maxValue2.toDouble();
  }

  List<SsiPointData> _setSsiPointDataList(List<double> yList, Color color) {
    List<SsiPointData> ssiPointDatas = [];
    for (int index = 0; index < yList.length; index++) {
      ssiPointDatas.add(_setSsiPointData(index + 1, yList[index], color));
    }
    return ssiPointDatas;
  }

  SsiPointData _setSsiPointData(double x, double y, Color color) {
    NumberFormat format = NumberFormat();
    return SsiPointData(
      pointText: format.format(y),
      x: x,
      y: y,
      lineTouchData: SsiLineTouchData(
        tipWindowSize: const Size(60, 20),
        onTouch: () {
          return _buildMarker(format.format(y), color);
        },
      ),
    );
  }

  Container _buildMarker(String value, Color color) {
    return Container(
      child: Center(
          child: Text(
        value + "分",
        style: const TextStyle(
            fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
      )),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  List<SsiDialItem> _xDialValuesForExample1(List<String> xList) {
    List<SsiDialItem> _xDialValue = [];
    for (int index = 0; index < xList.length; index++) {
      _xDialValue.add(SsiDialItem(
        dialText: xList[index],
        dialTextStyle:
            const TextStyle(fontSize: 10.0, color: Color(0xFFA2A2A2)),
        value: index.toDouble() + 1,
      ));
    }
    return _xDialValue;
  }

  List<SsiDialItem> _yDialValuesForExample1(double itemValue) {
    List<SsiDialItem> _yDialValue = [];
    NumberFormat format = NumberFormat();
    for (int index = 0; index < 6; index++) {
      _yDialValue.add(SsiDialItem(
        dialText:  format.format(itemValue * index),
          dialTextStyle:
            const TextStyle(fontSize: 10.0, color: Color(0xFFA2A2A2)),
        value: itemValue * index,
      ));
    }
    return _yDialValue;
  }

  ////////////////////////////
  Widget _brokenLineExample2(context) {
    List<double> yAisList = [];
    yAisList.addAll(y1List);
    yAisList.addAll(y2List);
    var chartLine = SsiBrokenLine(
      showPointDashLine: false,
      isTipWindowAutoDismiss: false,
      lines: _linesForExample2(),
      size: Size(MediaQuery.of(context).size.width - 40 * 2,
          MediaQuery.of(context).size.height / 5 * 1.6 - 20 * 2),
      isShowXHintLine: true,
      // yHintLineOffset: 40,
      yDialValues:
          _yDialValuesForExample1(_getMaxValueForExample1(yAisList) / 5),
      yDialMin: 0,
      yDialMax: _getMaxValueForExample1(yAisList),
      xDialValues: _xDialValuesForExample1(xAisList),
      xDialMin: 1,
      xDialMax: xAisList.length.toDouble(),
      isHintLineSolid: false,
      isShowYDialText: true,
    );
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 14,
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsetsDirectional.only(start: 15, top: 4),
                width: 4,
                height: 16,
                decoration: BoxDecoration(
                  color: const Color(0xFF0050B3),
                  borderRadius: BorderRadius.circular((1.0)),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text('多折线图',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF333333),
                      fontWeight: FontWeight.bold)),
            ],
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 14),
            child: chartLine,
          ),
        ],
      ),
    );
  }

  List<SsiPointsLine> _linesForExample2() {
    SsiPointsLine _pointsLine;
    SsiPointsLine _pointsLine2;
    List<SsiPointsLine> pointsLineList = [];
    _pointsLine = SsiPointsLine(
      isShowPointText: false,
      isShowXDial: true,
      lineWidth: 3,
      pointRadius: 4,
      isShowPoint: true,
      isCurve: false,
      points: _setSsiPointDataList(y1List, color1),
      shaderColors: [color1.withOpacity(0.3), color1.withOpacity(0.01)],
      lineColor: color1,
    );
    _pointsLine2 = SsiPointsLine(
      isShowPointText: false,
      isShowXDial: true,
      lineWidth: 3,
      pointRadius: 4,
      isShowPoint: true,
      isCurve: false,
      points: _setSsiPointDataList(y2List, color2),
      shaderColors: [color2.withOpacity(0.3), color2.withOpacity(0.01)],
      lineColor: color2,
    );

    pointsLineList.add(_pointsLine);
    pointsLineList.add(_pointsLine2);
    return pointsLineList;
  }
}
