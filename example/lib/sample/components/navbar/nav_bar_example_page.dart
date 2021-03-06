import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_ssikit/flutter_ssikit.dart';

class NavBarPage extends StatefulWidget {
  final int index;

  NavBarPage(this.index);

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> with TickerProviderStateMixin {
  late TextEditingController textEditingController;

  late TextStyle selectedHeiStyle;
  late TextStyle unSelectedHeiStyle;
  late TextStyle commonHeiStyle;

  late TextStyle selectedBaiStyle;
  late TextStyle unSelectedBaiStyle;
  late TextStyle commonBaiStyle;
  int currentIndex = 0;

  late ValueNotifier<bool> valueNotifier;
  late FocusNode focusNode;

  late TabController tabController;

  var keyleading = GlobalKey();

  var actionKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    valueNotifier = ValueNotifier(false);

    selectedHeiStyle = TextStyle(
        fontSize: 18, color: Color(0xFFFFFFFF), fontWeight: FontWeight.w600);
    selectedBaiStyle = TextStyle(
        fontSize: 18, color: Color(0xFF222222), fontWeight: FontWeight.w600);

    unSelectedHeiStyle = TextStyle(
        fontSize: 18, color: Color(0xFF999999), fontWeight: FontWeight.w600);
    unSelectedBaiStyle = TextStyle(
        fontSize: 18, color: Color(0xFF999999), fontWeight: FontWeight.w600);

    commonHeiStyle = TextStyle(
        fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white);
    commonBaiStyle = TextStyle(
        fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF222222));

    focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        valueNotifier.value = true;
      }
    });

    tabController = TabController(vsync: this, length: 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildBarByIndex(context),
      body: buildContentByIndex(context),
    );
  }

  PreferredSizeWidget? buildBarByIndex(BuildContext context) {
    PreferredSizeWidget? appBar;
    switch (widget.index) {
      case 0:
        //2????????????????????? ????????????icon hei
        appBar = _getBlackBar1();
        break;

      case 4:
        //???????????? ???2???icon ?????????
        appBar = _getBlackBar5();
        break;

      case 5:
        //???????????? ?????????
        appBar = _getBlackBar6();
        break;

      case 8:
        ////???????????? ???1???icon ?????????
        appBar = _getBlackBar9();
        break;

      case 9:
        ////????????????  ?????????
        appBar = _getBlackBar10();
        break;

      case 10:
        //???????????? ???2???icon ?????????
        appBar = _getBlackBar11();
        break;

      case 11:
        appBar = _getBlackBar12();
        break;

      case 12:
        appBar = _getBlackBar13();
        break;

      case 14:
        //???????????????
        appBar = _getBlackBar15();
        break;

      case 19:
        //???????????????
        appBar = _getAppBarWithSearchResult();
        break;

      case 30:
        appBar = _getGradientAppbar();
        break;
      case 31:
        appBar = _getGradientAppbarTitleLeft();
        break;
      case 32:
        appBar = _getGradientAppbarNoBack();
      break;
      default:
    }
    return appBar;
  }

  Widget buildContentByIndex(BuildContext context) {
    Widget? widget;
    switch (this.widget.index) {
      case 0:
        widget = Center(
            child: Text(
                '1. ???????????????????????????????????????????????????????????????????????????\n2.????????????????????????\n3.????????????????????????????????????????????????'));
        break;
      case 4:
        widget = Center(child: Text('???Actions'));
        break;
      case 13:
        widget = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
          ],
        );
        break;
      default:
    }

    return widget ?? Container();
  }

  //2????????????????????? ????????????icon hei
  SsiAppBar _getBlackBar1() {
    return SsiAppBar(
      leading: SsiBackLeading(
        child: Image.asset(
          'assets/image/icon_navbar_sousuo_bai.png',
          scale: 3.0,
          height: 20,
          width: 20,
        ),
      ),
      brightness: Brightness.dark,
      // backgroundColor: Colors.amberAccent,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              currentIndex = 0;
              setState(() {});
            },
            child: Text(
              '??????',
              style: currentIndex == 0 ? selectedHeiStyle : unSelectedHeiStyle,
            ),
          ),
          SizedBox(
            width: 24,
          ),
          GestureDetector(
            onTap: () {
              currentIndex = 1;
              setState(() {});
            },
            child: Text(
              '??????',
              style: currentIndex == 1 ? selectedHeiStyle : unSelectedHeiStyle,
            ),
          )
        ],
      ),
      actions: SsiIconAction(
        child: Image.asset(
          'assets/image/icon_navbar_add_bai.png',
          scale: 3.0,
          width: 20,
          height: 20,
        ),
        iconPressed: () {
          SsiToast.show('?????????????????????+???', context);
        },
      ),
    );
  }

  //???????????? ???2???icon ?????????
  SsiAppBar _getBlackBar5() {
    return SsiAppBar(
      title: '????????????',
      leading: SsiDoubleLeading(
        first: SsiBackLeading(),
        second: SsiBackLeading(
          child: Image.asset(
            'assets/image/icon_navbar_close_hei.png',
            scale: 3.0,
            height: 20,
            width: 20,
          ),
        ),
      ),
      actions: SsiTextAction(
        '????????????',
        key: actionKey,
        textPressed: () {
          SsiPopupListWindow.showPopListWindow(context, actionKey,
              offset: 10, data: ["aaaa", "bbbbb"]);
        },
      ),
    );
  }

  //???????????? ?????????
  SsiAppBar _getBlackBar6() {
    return SsiAppBar(
      brightness: Brightness.dark,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "????????????",
            style: commonHeiStyle,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Image.asset(
              'assets/image/icon_navbar_xiala_bai.png',
              scale: 3.0,
              width: 20,
              height: 20,
            ),
          )
        ],
      ),
    );
  }

  //???????????? ???1???icon ????????? bai
  SsiAppBar _getBlackBar9() {
    return SsiAppBar(
      brightness: Brightness.light,
      leading: Image.asset(
        'assets/image/icon_navbar_sousuo_hei.png',
        scale: 3.0,
        width: 20,
        height: 20,
      ),
      title: '????????????',
    );
  }

  //???????????? ?????????
  SsiAppBar _getBlackBar10() {
    return SsiAppBar(
      brightness: Brightness.light,
      leading: Image.asset(
        'assets/image/icon_navbar_sousuo_hei.png',
        scale: 3.0,
        width: 20,
        height: 20,
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '????????????',
            style: TextStyle(
                fontSize: 18,
                height: 1,
                fontWeight: FontWeight.w600,
                color: Color(0xFF222222)),
          ),
          Container(
              height: 17,
              padding: EdgeInsets.only(left: 3, right: 3),
              margin: EdgeInsets.only(left: 6),
              decoration:
                  BoxDecoration(color: Color(0xff8E8E8E).withOpacity(0.15)),
              child: Center(
                child: Text(
                  '??????',
                  overflow: TextOverflow.ellipsis,
                  textScaleFactor: 1,
                  style: TextStyle(
                    fontSize: 11,
                    height: 1,
                    color: Color(0xFF222222),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  //???????????? ???2???icon ?????????
  SsiAppBar _getBlackBar11() {
    return SsiAppBar(
      brightness: Brightness.light,
      title: '????????????',
      leading: SsiDoubleLeading(
        first: SsiBackLeading(),
        second: SsiBackLeading(
          child: Image.asset(
            'assets/image/icon_navbar_close_hei.png',
            scale: 3.0,
            height: 20,
            width: 20,
          ),
        ),
      ),
      actions: SsiTextAction(
        '????????????',
      ),
    );
  }

  //???icon???bar hei
  SsiAppBar _getBlackBar12() {
    return SsiAppBar(
      brightness: Brightness.dark,
      automaticallyImplyLeading: true,
      title: "?????????????????????????????????????????????????????????????????????????????????",
      actions: <Widget>[
        SsiIconAction(
          iconPressed: () {},
          child: Image.asset(
            'assets/image/icon_navbar_share_bai.png',
            scale: 3.0,
            height: 20,
            width: 20,
          ),
        ),
        SsiIconAction(
          iconPressed: () {},
          child: Image.asset(
            'assets/image/icon_navbar_pin_bai.png',
            scale: 3.0,
            height: 20,
            width: 20,
          ),
        ),
        SsiIconAction(
          iconPressed: () {},
          child: Image.asset(
            'assets/image/icon_navbar_focus_bai.png',
            scale: 3.0,
            height: 20,
            width: 20,
          ),
        ),
      ],
    );
  }

  //???icon???bar bai
  SsiAppBar _getBlackBar13() {
    return SsiAppBar(
      brightness: Brightness.light,
      automaticallyImplyLeading: true,
      title: "",
      actions: <Widget>[
        SsiIconAction(
          iconPressed: () {},
          child: Image.asset(
            'assets/image/icon_navbar_im_hei.png',
            scale: 3.0,
            height: 20,
            width: 20,
          ),
        ),
        SsiIconAction(
          iconPressed: () {},
          child: Image.asset(
            'assets/image/icon_navbar_share_hei.png',
            scale: 3.0,
            height: 20,
            width: 20,
          ),
        ),
        SsiIconAction(
          iconPressed: () {},
          child: Image.asset(
            'assets/image/icon_navbar_pin_hei.png',
            scale: 3.0,
            height: 20,
            width: 20,
          ),
        ),
        SsiIconAction(
          iconPressed: () {},
          child: Image.asset(
            'assets/image/icon_navbar_focus_hei.png',
            scale: 3.0,
            height: 20,
            width: 20,
          ),
        ),
      ],
    );
  }

  PreferredSize _getAppBarWithSearchResult() {
    return SsiAppBar.buildSearchResultStyle(
      title: '?????????????????????????????????????????????????????????????????????????????????',
      showLeadingDivider: false,
    );
  }

  SsiAppBar _getBlackBar15() {
    Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            currentIndex = 0;
            setState(() {});
          },
          child: Text(
            '??????',
            style: currentIndex == 0 ? selectedHeiStyle : unSelectedHeiStyle,
          ),
        ),
        SizedBox(
          width: 24,
        ),
        GestureDetector(
          onTap: () {
            currentIndex = 1;
            setState(() {});
          },
          child: Text(
            '??????',
            style: currentIndex == 1 ? selectedHeiStyle : unSelectedHeiStyle,
          ),
        ),
        SizedBox(
          width: 24,
        ),
        GestureDetector(
          onTap: () {
            currentIndex = 2;
            setState(() {});
          },
          child: Text(
            '??????',
            style: currentIndex == 2 ? selectedHeiStyle : unSelectedHeiStyle,
          ),
        )
      ],
    );
    return SsiAppBar(
      brightness: Brightness.dark,
      automaticallyImplyLeading: false,
      //?????????leading
      leading: SsiBackLeading(
        child: Image.asset(
          'assets/image/icon_navbar_sousuo_bai.png',
          scale: 3.0,
          height: 20,
          width: 20,
        ),
      ),
      //?????????title
      title: Container(
        height: 44,
        padding: EdgeInsets.only(left: 24, right: 12),
        child: ListView.separated(
          itemCount: 10,
          //??????
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  this.currentIndex = index;
                });
              },
              child: Center(
                child: Text(
                  '??????',
                  style: index == currentIndex
                      ? selectedHeiStyle
                      : unSelectedHeiStyle,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 24,
            );
          },
        ),
      ),
      actions: SsiIconAction(
        child: Image.asset(
          'assets/image/icon_navbar_add_bai.png',
          scale: 3.0,
          height: 20,
          width: 20,
        ),
        iconPressed: () {},
      ),
    );
  }

  PreferredSizeWidget? _getGradientAppbar() {
    return GradientAppbar(
      appBar: SsiAppBar(
        title: '????????????',
        themeData: SsiAppBarConfig.dark(),
        backgroundColor: Colors.transparent,
        brightness: Brightness.dark,
        leading: SsiBackLeading(themeData: SsiAppBarConfig.dark(),),
        actions: SsiTextAction(
          '????????????',
          key: actionKey,
          textPressed: () {
            SsiPopupListWindow.showPopListWindow(context, actionKey,
                offset: 10, data: ["aaaa", "bbbbb"]);
          },
        ),
      ),
      colors: [Colors.red, Colors.orange.shade700],
    );
  }

  PreferredSizeWidget? _getGradientAppbarNoBack() {
    return GradientAppbar(
      appBar: SsiAppBar(
        automaticallyImplyLeading: false,  
        title: '????????????',
        themeData: SsiAppBarConfig.dark(),
        backgroundColor: Colors.transparent,
      ),
      colors: [Colors.red, Colors.orange.shade700],
    );
  }

  PreferredSizeWidget? _getGradientAppbarTitleLeft() {
    return GradientAppbar(
      appBar: SsiAppBar(
        automaticallyImplyLeading: false,  
        title: '????????????',
        themeData: SsiAppBarConfig.dark(),
        centerTitle: false,
        leading: const SizedBox(),
        leadingWidth: 20,
        backgroundColor: Colors.transparent,
        brightness: Brightness.dark,
        titleAlignment: Alignment.centerLeft,
        actions: SsiTextAction(
          '????????????',
          key: actionKey,
          textPressed: () {
            SsiPopupListWindow.showPopListWindow(context, actionKey,
                offset: 10, data: ["aaaa", "bbbbb"]);
          },
        ),
      ),
      colors: [Colors.red, Colors.orange.shade700],
    );
  }
}

class GradientAppbar extends StatelessWidget implements PreferredSizeWidget {
  final SsiAppBar appBar;
  final List<Color> colors;

  AlignmentGeometry begin;
  AlignmentGeometry end;

  GradientAppbar({
    Key? key,
    required this.appBar,
    required this.colors,
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: LinearGradient(colors: colors, begin: begin, end: end), //????????????
          // boxShadow: const [
          //   //??????
          //   BoxShadow(
          //       color: Colors.black54,
          //       offset: Offset(2.0, 2.0),
          //       blurRadius: 4.0)
          // ]
      ),
      child: appBar,
    );
  }

  @override
  Size get preferredSize => appBar.preferredSize;
}
