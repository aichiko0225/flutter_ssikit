import 'package:flutter/material.dart';
import 'package:flutter_ssikit/flutter_ssikit.dart';

class PopWindowExamplePage extends StatefulWidget {
  final String _title;

  PopWindowExamplePage(this._title);

  @override
  State<StatefulWidget> createState() => PopWindowExamplePageState();
}

class PopWindowExamplePageState extends State<PopWindowExamplePage> {
  late GlobalKey _leftKeylist0;
  late GlobalKey _leftKeylist1;
  late GlobalKey _leftKeylist2;
  late GlobalKey _leftKeylist3;
  late GlobalKey _leftKey;
  late GlobalKey _leftKey1;
  late GlobalKey _leftKey2;
  late GlobalKey _leftKey3;
  late GlobalKey _leftKey4;
  late GlobalKey _leftKey5;
  late GlobalKey _leftKey6;
  late GlobalKey _leftKey7;

  late SsiOverlayController overlayController;

  @override
  void initState() {
    super.initState();
    _leftKeylist0 = GlobalKey();
    _leftKeylist1 = GlobalKey();
    _leftKeylist2 = GlobalKey();
    _leftKeylist3 = GlobalKey();
    _leftKey = GlobalKey();
    _leftKey1 = GlobalKey();
    _leftKey2 = GlobalKey();
    _leftKey3 = GlobalKey();
    _leftKey4 = GlobalKey();
    _leftKey5 = GlobalKey();
    _leftKey6 = GlobalKey();
    _leftKey7 = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    double top = MediaQuery.of(context).padding.top;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget._title),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: RaisedButton(
                  key: _leftKey,
                  onPressed: () {
                    SsiPopupWindow.showPopWindow(context, "提示内容", _leftKey,
                        hasCloseIcon: true);
                  },
                  child: Text("左侧带关闭Tips"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: RaisedButton(
                  key: _leftKey1,
                  onPressed: () {
                    SsiPopupWindow.showPopWindow(
                        context, "提示内容提示内容提示内容提示内容提示内容提示内容提示内容提示内容", _leftKey1,
                        hasCloseIcon: false);
                  },
                  child: Text("左侧带无关闭Tips"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: RaisedButton(
                  key: _leftKey2,
                  onPressed: () {
                    SsiPopupWindow.showPopWindow(context,
                        "提示内容提示内容提示内容提示内容提示内容提示内容提示内容提示内容提示内容", _leftKey2,
                        popDirection: SsiPopupDirection.top,
                        hasCloseIcon: true);
                  },
                  child: Text("左侧带关闭，箭头朝下Tips"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: RaisedButton(
                  key: _leftKey3,
                  onPressed: () {
                    SsiPopupWindow.showPopWindow(
                        context, "提示内容提示内容提示内容提示内容提示内容提示内容提示内容提示内容", _leftKey3,
                        dismissCallback: () {},
                        popDirection: SsiPopupDirection.top);
                  },
                  child: Text("左侧无关闭，箭头朝下Tips"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 250),
                child: RaisedButton(
                  key: _leftKey4,
                  onPressed: () {
                    SsiPopupWindow.showPopWindow(
                        context, "提示内容提示内容提示内容提示内容提示内容提示内容提示内容提示内容", _leftKey4,
                        hasCloseIcon: true,
                        dismissCallback: () {},
                        popDirection: SsiPopupDirection.bottom);
                  },
                  child: Text("右侧带关闭Tips"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 250),
                child: RaisedButton(
                  key: _leftKey5,
                  onPressed: () {
                    SsiPopupWindow.showPopWindow(
                        context, "提示内容提示内容提示内容提示内容", _leftKey5,
                        hasCloseIcon: false,
                        dismissCallback: () {},
                        popDirection: SsiPopupDirection.bottom);
                  },
                  child: Text("右侧无关闭Tips"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 250),
                child: RaisedButton(
                  key: _leftKey6,
                  onPressed: () {
                    SsiPopupWindow.showPopWindow(
                        context, "提示内容提示内容提示内容提示内容提示内容提示内容", _leftKey6,
                        hasCloseIcon: true,
                        canWrap: false,
                        dismissCallback: () {},
                        popDirection: SsiPopupDirection.top);
                  },
                  child: Text("右侧带关闭，箭头朝下Tips"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 250),
                child: RaisedButton(
                  key: _leftKey7,
                  onPressed: () {
                    SsiPopupWindow.showPopWindow(
                        context, "提示内容提示内容提示内容提示内容提示内容提示内容", _leftKey7,
                        hasCloseIcon: false,
                        dismissCallback: () {},
                        popDirection: SsiPopupDirection.top);
                  },
                  child: Text("右侧无关闭，箭头朝下Tips"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: RaisedButton(
                  key: _leftKeylist0,
                  onPressed: () {
                    SsiPopupListWindow.showButtonPanelPopList(
                        context, _leftKeylist0,
                        data: ['选项一', '选项二', '选项三']);
                  },
                  child: Text("Popup列表 - 左侧Tips"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: RaisedButton(
                  key: _leftKeylist1,
                  onPressed: () {
                    SsiPopupListWindow.showPopListWindow(context, _leftKeylist1,
                        data: ['选项一选项一选项一选项一选项一选项一选项一选项一选项一', '选项二', '选项三'],
                        spaceMarginOffset: 30,
                        onItemClick: (index, item) {
                      SsiToast.show(item, context);
                    });
                  },
                  child: Text("Popup列表 - 左侧Tips"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 250),
                child: RaisedButton(
                  key: _leftKeylist2,
                  onPressed: () {
                    SsiPopupListWindow.showPopListWindow(context, _leftKeylist2,
                        data: ['选项一', '选项二', '选项三'],
                        spaceMarginOffset: 30,
                        onItemClick: (index, item) {
                      SsiToast.show(item, context);
                    });
                  },
                  child: Text("Popup列表 - 右侧Tips"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 250),
                child: RaisedButton(
                  key: _leftKeylist3,
                  onPressed: () {
                    SsiPopupListWindow.showPopListWindow(context, _leftKeylist3,
                        data: ['选项一', '选项二', '选项三'],
                        popDirection: SsiPopupDirection.top,
                        onItemClick: (index, item) {
                      SsiToast.show(item, context);
                    });
                  },
                  child: Text("Popup列表 - 右侧箭头朝下Tips"),
                ),
              ),
            ],
          ),
        ));
  }
}
