import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ssikit/flutter_ssikit.dart';

class BrokenLineExamplePage extends StatefulWidget {
  @override
  _BrokenLineExamplePageState createState() =>
      _BrokenLineExamplePageState();
}

class _BrokenLineExamplePageState extends State<BrokenLineExamplePage> {
  List<String> xAisList = [];
  List<double> yAisList = [];
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

    yAisList.add(0);
    yAisList.add(20);
    yAisList.add(40);
    yAisList.add(60);
    yAisList.add(80);
    yAisList.add(100);

    y1List.add(25);
    y1List.add(50);
    y1List.add(45);
    y1List.add(55);
    y1List.add(25);
    y1List.add(75);
    y1List.add(82);

    y2List.add(9);
    y2List.add(89);
    y2List.add(66);
    y2List.add(29);
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

          ],

        ),
      ),
    );
  }

  ////////////////////////////
  Widget _brokenLineExample1(context) {
    var chartLine = SsiBrokenLine(
      lines: _linesForExample1(),
      size: Size(MediaQuery.of(context).size.width - 50 * 2,
          MediaQuery.of(context).size.height / 5 * 1.6 - 20 * 2),
      isShowXHintLine: false,
      yHintLineOffset: 30,
      yDialValues: _yDialValuesForExample1(yAisList),
      yDialMin: 0,
      yDialMax: 100,
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
          const SizedBox(height: 14,),
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
              const SizedBox(width: 10,),
              const Text('折线图', style: TextStyle(fontSize: 16, color: Color(0xFF333333),fontWeight: FontWeight.bold)),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: chartLine,
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
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
      points: _setSsiPointDataList(y1List,color1),
      shaderColors: [color1.withOpacity(0.3), color1.withOpacity(0.01)],
      lineColor: color1,
    );

    pointsLineList.add(_pointsLine);
    return pointsLineList;
  }

  List<SsiPointData> _setSsiPointDataList(List<double> yList,Color color){
    List<SsiPointData> ssiPointDatas = [];
    for (int index = 0; index < yList.length; index++) {
      ssiPointDatas.add(_setSsiPointData(index+1,yList[index],color));
    }
    return ssiPointDatas;
  }

  SsiPointData _setSsiPointData(double x,double y,Color color){
    return SsiPointData(
      pointText: y.toString(),
      x: x,
      y: y,
      lineTouchData: SsiLineTouchData(
        tipWindowSize: const Size(60, 20),
        onTouch: () {
          return _buildMarker(y.toString(),color);
        },
      ),
    );
  }

  Container _buildMarker(String value,Color color) {
    return Container(
      child: Center(
          child: Text(
            value+"分",
            style:
            const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
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
        dialTextStyle: const TextStyle(fontSize: 10.0, color: Color(0xFFA2A2A2)),
        value: index.toDouble()+1,
      ));
    }
    return _xDialValue;
  }

  List<SsiDialItem> _yDialValuesForExample1(List<double> yList) {
    List<SsiDialItem> _yDialValue = [];
    for (int index = 0; index < yList.length; index++) {
      _yDialValue.add(SsiDialItem(
        dialText: yList[index].toString(),
        dialTextStyle: const TextStyle(fontSize: 10.0, color: Color(0xFFA2A2A2)),
        value: yList[index],
      ));
    }
    return _yDialValue;
  }

  ////////////////////////////
  Widget _brokenLineExample2(context) {
    var chartLine = SsiBrokenLine(
      lines: _linesForExample2(),
      size: Size(MediaQuery.of(context).size.width - 50 * 2,
          MediaQuery.of(context).size.height / 5 * 1.6 - 20 * 2),
      isShowXHintLine: true,
      yHintLineOffset: 30,
      yDialValues: _yDialValuesForExample1(yAisList),
      yDialMin: 0,
      yDialMax: 100,
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
          const SizedBox(height: 14,),
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
              const SizedBox(width: 10,),
              const Text('多折线图', style: TextStyle(fontSize: 16, color: Color(0xFF333333),fontWeight: FontWeight.bold)),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: chartLine,
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
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
      points: _setSsiPointDataList(y1List,color1),
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
      points: _setSsiPointDataList(y2List,color2),
      shaderColors: [color2.withOpacity(0.3), color2.withOpacity(0.01)],
      lineColor: color2,
    );

    pointsLineList.add(_pointsLine);
    pointsLineList.add(_pointsLine2);
    return pointsLineList;
  }

}
