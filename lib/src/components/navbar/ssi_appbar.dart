// ignore_for_file: unnecessary_null_comparison, empty_constructor_bodies

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ssikit/src/components/line/ssi_line.dart';
import 'package:flutter_ssikit/src/constants/ssi_asset_constants.dart';
import 'package:flutter_ssikit/src/constants/ssi_strings_constants.dart';
import 'package:flutter_ssikit/src/theme/ssi_theme.dart';

import '../../theme/configs/ssi_appbar_config.dart';
import 'ssi_appbar_theme.dart';

/// AppBar组件,基于[AppBar]封装。为了解决原生的AppBar对Leading宽度的限制
/// 在1.21版本之后，Flutter放开了宽度的限制[https://github.com/flutter/flutter/blob/flutter-1.21-candidate.0/packages/flutter/lib/src/material/app_bar.dart]
///
/// 布局规则：
///    leading是左侧显示的内容
///    title是中间显示的内容
///    action是右侧显示的内容
///    呈现的依然是AppBar，优化点在于：第一 title可以传入String
///                               第二 action和leading 封装了快捷使用
///
/// 用户如果想自定义 使用效果完全可以传入appbar的属性
///
/// 布局步骤：同appbar默认的布局 先leading、后action，最后title
///
///    首先，计算leading的宽度 外部传入则可以leadingWidth 则已外部传入为主
///
///         该组件为[SsiDoubleLeading]和[SsiBackLeading]提供了计算
///         leading默认的大小是[SsiAppBarConfig.leadingSize],
///         [SsiDoubleLeading]的大小是 但是Leading的宽度的2倍+间距
///
///         leadingWidth默认宽度为SsiAppBarConfig.leadingSize
///         如果传入的leading是完全自定义的Widget，可以自行设置leadingWidth
///
///    其次，摆放action
///
///    最后，对齐title
///
/// 组件支持两种显示模式深色和浅色。 通过[SsiAppBar.brightness]属性设置，
/// 深色[Brightness.dark]模式，背景色是黑色，icon和文字颜色是白色。
/// 浅色[Brightness.light]模式，背景色是白色，icon和文字颜色是黑色。
/// 如果使用默认的[SsiBackLeading]和[SsiAppBarTitle]
/// BkAppBar中的文字颜色和backLeading可自动随着[SsiAppBar.brightness]变化。
///
/// 组件提供了默认的返回leading，如果不需要默认的leading可以设置[automaticallyImplyLeading]为false
/// 默认的leading，提供了默认的返回[Navigator.pop(context)]，
/// 如果是native打开的话，可能需要单独处理,否则会出现白屏
///
/// 其他属性同AppBar本身的含义
///
/// 显示：返回按钮、Appbar示例文本
/// SsiAppBar(
///   title: 'Appbar示例',
/// )
///
/// 显示：自定义leading、tab切换、自定义action
/// SsiAppBar(
///   leading: SsiBackLeading(),
///   title: Row(
///   mainAxisSize: MainAxisSize.min,
///      crossAxisAlignment: CrossAxisAlignment.start,
///      children: <Widget>[
///      GestureDetector(
///         onTap: () {
///           currentIndex = 0;
///           setState(() {});
///          },
///         child: Text(
///           '二手',
///            style: currentIndex == 0 ? selectedHeiStyle : unSelectedHeiStyle,
///           ),
///      ),
///      SizedBox(
///         width: 24,
///      ),
///      GestureDetector(
///         onTap: () {
///           currentIndex = 1;
///           setState(() {});
///         },
///         child: Text(
///           '新房',
///            style: currentIndex == 1 ? selectedHeiStyle : unSelectedHeiStyle,
///         ),
///       )
///      ],
///    ),
///  actions: SsiIconAction()
///
/// 相关组件如下:
///  * [SsiBackLeading], 自定义leading，单个文本或按钮
///  * [SsiDoubleLeading], 自定义leading，两个文本或按钮
///  * [SsiAppBarTitle], 自定义title，纯文本展示
///  * [SsiIconAction], 自定义action，显示icon
///  * [SsiTextAction], 自定义action，纯文本展示
///  * [SsiBarBottomDivider], appbar与其他元素的分割线，同[SsiLine]
///
///
class SsiAppBar extends PreferredSize {
  /// 导航栏左侧活动区域,在为null且
  /// [automaticallyImplyLeading]为true时默认赋值为[SsiBackLeading]
  final Widget? leading;

  /// AppBar标题,必须是String或者Widget类型
  /// 为String时,会使用[SsiAppBarTitle]来加载title
  final dynamic title;

  /// 为了方便业务使用，可以设置为Widget或者List<Widget>
  /// 传入的Widget会自动添加边距并转化为List<Widget>
  /// 传入的List<Widget>会自动添加右边距和action之间的间距
  final dynamic actions;

  /// 是否自动添加Leading实现
  final bool automaticallyImplyLeading;

  /// 以下属性都对应于[AppBar]中的属性
  /// 详细介绍可以查阅[AppBar]的文档
  final Color? backgroundColor;
  final PreferredSizeWidget? bottom;
  final double? elevation;
  final Brightness? brightness;
  final double toolbarOpacity;
  final double bottomOpacity;
  final Alignment titleAlignment;
  final Widget? flexibleSpace;
  final double? leadingWidth;
  final Color? shadowColor;
  final ShapeBorder? shape;
  final IconThemeData? iconTheme;
  final IconThemeData? actionsIconTheme;
  final TextTheme? textTheme;
  final bool primary;
  final bool excludeHeaderSemantics;
  final double? titleSpacing;

  /// 默认处理了返回按钮，flutter的pop，如果是native打开的话，可能需要单独处理,否则会出现白屏
  /// backLeadCallback是默认的处理回调
  /// DefaultLeadingCallBack 也可以通过改方法参数 设置统一的返回处理，该参数是静态的
  final VoidCallback? backLeadCallback;

  /// 是否显示默认的eeeeee分割线，默认显示，可以设置为不显示
  final bool showDefaultBottom;
  final bool showLeadingDivider;
  final SsiAppBarConfig? themeData;

  SsiAppBar(
      {Key? key,
      this.leading,
      this.showLeadingDivider = false,
      this.title,
      this.actions,
      this.backgroundColor,
      this.bottom,
      this.elevation,
      this.automaticallyImplyLeading = true,
      this.brightness,
      this.toolbarOpacity = 1.0,
      this.bottomOpacity = 1.0,
      this.titleAlignment = Alignment.center,
      this.flexibleSpace,
      this.backLeadCallback,
      this.showDefaultBottom = true,
      this.themeData,
      this.leadingWidth,
      this.shadowColor,
      this.shape,
      this.iconTheme,
      this.actionsIconTheme,
      this.excludeHeaderSemantics = false,
      this.primary = true,
      this.textTheme,
      this.titleSpacing})
      : assert(
            actions == null || actions is Widget || (actions is List<Widget>)),
        assert(title == null || title is String || title is Widget),
        super(key: key, child: _getChild(), preferredSize: _getPreferredSize());

  SsiAppBar.buildSearchResultStyle(
      {Key? key,
      String? title,
      this.backgroundColor,
      this.bottom,
      this.brightness,
      this.showLeadingDivider = true,
      this.flexibleSpace,
      this.backLeadCallback,
      this.showDefaultBottom = true,
      this.themeData,
      this.leadingWidth,
      this.shadowColor,
      this.shape,
      this.iconTheme,
      this.actionsIconTheme,
      this.excludeHeaderSemantics = false,
      this.primary = true,
      this.textTheme,
      this.titleSpacing})
      : actions = null,
        elevation = 0,
        toolbarOpacity = 1.0,
        bottomOpacity = 1.0,
        leading = null,
        automaticallyImplyLeading = false,
        titleAlignment = Alignment.centerLeft,
        title = _SsiSearchResultAppBar(
          appBarConfig: themeData,
          backgroundColor: backgroundColor,
          title: title,
          bottom: bottom,
          brightness: brightness,
          showLeadingDivider: showLeadingDivider,
          flexibleSpace: flexibleSpace,
          backLeadCallback: backLeadCallback,
          showDefaultBottom: showDefaultBottom,
        ),
        super(key: key, child: _getChild(), preferredSize: _getPreferredSize());

  static Size _getPreferredSize() {
    SsiAppBarConfig _defaultConfig = SsiAppBarConfig();
    return Size.fromHeight(_defaultConfig.appBarHeight);
  }

  static Widget _getChild() {
    return AppBar();
  }

  @override
  Size get preferredSize {
    SsiAppBarConfig _defaultConfig = SsiThemeConfigurator.instance
            .getConfig()
            ?.appBarConfig
            ?.merge(themeData) ??
        SsiAppBarConfig();

    return Size.fromHeight(
        _defaultConfig.appBarHeight + (bottom?.preferredSize.height ?? 0.0));
  }

  @override
  Widget build(BuildContext context) {
    SsiAppBarConfig _defaultConfig = SsiThemeConfigurator.instance
            .getConfig()
            ?.appBarConfig
            ?.merge(themeData) ??
        SsiAppBarConfig();
    //当外部传入主题
    if (brightness == Brightness.light) {
      _defaultConfig = _defaultConfig.merge(SsiAppBarConfig.light());
    } else if (brightness == Brightness.dark) {
      _defaultConfig = _defaultConfig.merge(SsiAppBarConfig.dark());
    }
    _defaultConfig =
        _defaultConfig.merge(SsiAppBarConfig(backgroundColor: backgroundColor));

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(_defaultConfig.systemUiOverlayStyle);
    });
    return super.build(context);
  }

  PreferredSizeWidget? _buildBarBottom() {
    if (brightness == null || brightness == Brightness.light) {
      if (bottom == null && showDefaultBottom) {
        return SsiBarBottomDivider();
      }
    }
    return bottom;
  }

  @override
  Widget get child {
    SsiAppBarConfig _defaultConfig =
        SsiThemeConfigurator.instance
            .getConfig()
            ?.appBarConfig
            ?.merge(themeData) ?? SsiAppBarConfig(backgroundColor: backgroundColor);
    //当外部传入主题
    if (brightness == Brightness.light) {
      _defaultConfig = _defaultConfig.merge(SsiAppBarConfig.light());
    } else if (brightness == Brightness.dark) {
      _defaultConfig = _defaultConfig.merge(SsiAppBarConfig.dark());
    }
    _defaultConfig =
        _defaultConfig.merge(SsiAppBarConfig(backgroundColor: backgroundColor));

    Widget? flexibleSpace;
    if (_defaultConfig.flexibleSpace != null) {
      flexibleSpace = Container(
        height: _defaultConfig.appBarHeight +
            MediaQueryData.fromWindow(window).padding.top,
        child: _defaultConfig.flexibleSpace,
      );
    }

    return AppBar(
      key: key,
      leading: _wrapLeading(_defaultConfig),
      leadingWidth: leadingWidth ?? _culLeadingSize(_defaultConfig),
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      title: _buildAppBarTitle(_defaultConfig),
      centerTitle: true,
      elevation: elevation ?? 0,
      backgroundColor: _defaultConfig.backgroundColor,
      actions: _wrapActions(_defaultConfig),
      bottom: _buildBarBottom(),
      brightness: brightness ?? Brightness.light,
      toolbarOpacity: toolbarOpacity,
      bottomOpacity: bottomOpacity,
      flexibleSpace: flexibleSpace,
      shadowColor: shadowColor,
      shape: shape,
      iconTheme: iconTheme,
      actionsIconTheme: actionsIconTheme,
      textTheme: textTheme,
      titleTextStyle: _defaultConfig.titleStyle?.generateTextStyle(),
      primary: primary,
      excludeHeaderSemantics: excludeHeaderSemantics,
      systemOverlayStyle: _defaultConfig.systemUiOverlayStyle,
    );
  }

  // 根据输入的leading 设置默认的leadingWidth
  double? _culLeadingSize(SsiAppBarConfig? themeData) {
    if (leadingWidth != null) {
      return leadingWidth;
    }
    if (themeData == null) {
      return null;
    }
    if (leading is SsiDoubleLeading) {
      return themeData.leftAndRightPadding +
          themeData.itemSpacing +
          themeData.iconSize * 2;
    }

    if (leading == null && !automaticallyImplyLeading) {
      return 0;
    }
    return themeData.leftAndRightPadding + themeData.iconSize;
  }

  // 对[actions]进行包装: 单一的Widget会添加右边距
  //                     List<Widget>在添加右边距的 并 添加action中的间距
  List<Widget>? _wrapActions(SsiAppBarConfig themeData) {
    if (actions == null || !(actions is List<Widget> || actions is Widget)) {
      return null;
    }
    List<Widget> actionList = <Widget>[];

    if (actions is List<Widget>) {
      if (actions.isEmpty) {
        return actionList;
      }
      List<Widget> tmp = (actions as List<Widget>).map((_) {
        return (_ is SsiTextAction) ? _warpRealAction(_) : _;
      }).toList();

      for (int i = 0, n = tmp.length; i < n; i++) {
        actionList.add(tmp[i]);
        if (i != n - 1) actionList.add(SizedBox(width: themeData.itemSpacing));
      }
    } else {
      Widget realAction =
          (actions is SsiTextAction) ? _warpRealAction(actions) : actions;
      actionList.add(realAction);
    }
    return actionList..add(SizedBox(width: themeData.leftAndRightPadding));
  }

  SsiTextAction _warpRealAction(SsiTextAction textAction) {
    return SsiTextAction(
      textAction.text,
      iconPressed: textAction.iconPressed,
      themeData: themeData,
      key: textAction.key,
    );
  }

  // 详情请参考_ToolbarLayout的布局方法
  Widget? _buildAppBarTitle(
    SsiAppBarConfig? themeData,
  ) {
    Widget? realTitle;
    if (title is Widget) {
      return title;
    }
    if (title is String) {
      realTitle = SsiAppBarTitle(
        title,
        themeData: themeData,
      );
    }

    return realTitle;
  }

  // 如果leading是SsiBackLeading 需要添加左边距
  Widget? _wrapLeading(SsiAppBarConfig? barConfig) {
    Widget? realLeading = leading;
    if (leading == null && automaticallyImplyLeading) {
      realLeading = SsiBackLeading(
        iconPressed: backLeadCallback,
        themeData: barConfig,
      );
    }
    if (realLeading is SsiBackLeading) {
      return Container(
        padding: EdgeInsets.only(left: barConfig?.leftAndRightPadding ?? 20),
        child: realLeading,
      );
    }
    return realLeading;
  }
}

/// [SsiAppBar]中leading的默认实现
/// 宽度范围是40
class SsiBackLeading extends StatelessWidget {
  final Widget? child;
  final VoidCallback? iconPressed;
  final SsiAppBarConfig? themeData;

  SsiBackLeading({
    Key? key,
    this.iconPressed,
    this.child,
    this.themeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SsiAppBarConfig _defaultThemeData = SsiThemeConfigurator.instance
            .getConfig()
            ?.appBarConfig
            ?.merge(themeData) ??
        SsiAppBarConfig();

    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
          width: _defaultThemeData.iconSize +
              _defaultThemeData.leftAndRightPadding,
          height: _defaultThemeData.appBarHeight),
      child: IconButton(
        alignment: Alignment.centerRight,
        icon: child ??
            (_defaultThemeData.leadIconBuilder != null
                ? _defaultThemeData.leadIconBuilder!()
                : _defaultBackImage()),
        onPressed: iconPressed ??
            () {
              /// 默认处理了返回按钮，flutter的pop，如果是native打开的话，可能需要单独处理,否则会出现白屏
              /// backLeadCallback是默认的处理回调
              /// DefaultLeadingCallBack 也可以通过改方法参数 设置统一的返回处理，该参数是静态的
              Navigator.maybePop(context);
            },
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _defaultBackImage() {
    return Image.asset(
      SsiAsset.ICON_BACK_BLACK,
      package: SsiStrings.flutterPackageName,
      width: SsiAppBarTheme.iconSize,
      height: SsiAppBarTheme.iconSize,
      fit: BoxFit.fitHeight,
    );
  }
}

/// 支持在[SsiAppBar.leading]添加两个元素的Leading实现
/// 宽度范围是80
class SsiDoubleLeading extends StatelessWidget {
  final Widget first;
  final Widget second;
  final SsiAppBarConfig? themeData;

  SsiDoubleLeading(
      {Key? key, required this.first, required this.second, this.themeData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SsiAppBarConfig _defaultThemeData = SsiThemeConfigurator.instance
            .getConfig()
            ?.appBarConfig
            ?.merge(themeData) ??
        SsiAppBarConfig();

    return Container(
      constraints: BoxConstraints.tightFor(
          height: _defaultThemeData.appBarHeight,
          width: _defaultThemeData.leftAndRightPadding +
              _defaultThemeData.itemSpacing +
              _defaultThemeData.iconSize * 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[first, second],
      ),
    );
  }
}

/// [SsiAppBar.title]的默认实现
/// 标题文字个数限制在8个以内，并且单行展示
class SsiAppBarTitle extends StatelessWidget {
  final String title;
  final SsiAppBarConfig? themeData;

  SsiAppBarTitle(this.title, {Key? key, this.themeData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SsiAppBarConfig _defaultThemeData = SsiThemeConfigurator.instance
            .getConfig()
            ?.appBarConfig
            ?.merge(themeData) ??
        SsiAppBarConfig();

    return ConstrainedBox(
      child: Text(
        title,
        style: _defaultThemeData.titleStyle?.generateTextStyle(),
        overflow: TextOverflow.ellipsis,
      ),
      constraints: BoxConstraints.loose(Size.fromWidth(
          (_defaultThemeData.titleStyle?.generateTextStyle().fontSize ?? 18) *
              (_defaultThemeData.titleMaxLength + 1))),
    );
  }
}

/// 在往[SsiAppBar.actions]中添加带icon的action时所使用的包装Widget
/// 此Widget中实现了大小约束，和点击实现，添加带icon类型的action时必须使用此类包裹
class SsiIconAction extends StatelessWidget {
  final Widget child;
  final VoidCallback iconPressed;
  final double size;
  final SsiAppBarConfig? themeData;

  SsiIconAction({
    Key? key,
    required this.iconPressed,
    required this.child,
    this.size = 20,
    this.themeData,
  })  : assert(child != null && iconPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    SsiAppBarConfig _defaultThemeData =
        SsiThemeConfigurator.instance
            .getConfig()
            ?.appBarConfig
            ?.merge(themeData) ?? SsiAppBarConfig(iconSize: size);

    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
          width: _defaultThemeData.iconSize,
          height: _defaultThemeData.iconSize),
      child: IconButton(
        icon: child,
        onPressed: iconPressed,
        padding: EdgeInsets.zero,
      ),
    );
  }
}

/// 在往[SsiAppBar.actions]中添加文本action时所使用的包装Widget
/// 此Widget中实现了大小约束，和点击实现，添加文本action时必须使用此类包裹
class SsiTextAction extends StatelessWidget {
  final String? text;
  final VoidCallback? iconPressed;
  final SsiAppBarConfig? themeData;

  SsiTextAction(this.text, {Key? key, this.iconPressed, this.themeData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SsiAppBarConfig _defaultThemeData = SsiThemeConfigurator.instance
            .getConfig()
            ?.appBarConfig
            ?.merge(themeData) ?? SsiAppBarConfig();

    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        child: Text(text ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: _defaultThemeData.actionsStyle?.generateTextStyle()),
      ),
      onTap: iconPressed,
    );
  }
}

/// AppBar底部分割线,将实例传入[SsiAppBar.bottom]属性即可
class SsiBarBottomDivider extends PreferredSize {
  SsiBarBottomDivider()
      : super(child: SsiLine(), preferredSize: Size.fromHeight(0.5));

  @override
  Size get preferredSize => Size.fromHeight(0.5);

  @override
  Widget get child => SsiLine();
}

class _SsiSearchResultAppBar extends StatelessWidget {
  final SsiAppBarConfig? appBarConfig;
  final String? title;
  final Color? backgroundColor;
  final bottom;
  final Brightness? brightness;
  final showLeadingDivider;
  final flexibleSpace;
  final backLeadCallback;
  final showDefaultBottom;

  _SsiSearchResultAppBar(
      {this.appBarConfig,
      this.backgroundColor,
      this.bottom,
      this.title,
      this.brightness = Brightness.dark,
      this.showLeadingDivider = true,
      this.flexibleSpace,
      this.backLeadCallback,
      this.showDefaultBottom = true});

  @override
  Widget build(BuildContext context) {
    SsiAppBarConfig _defaultConfig = SsiThemeConfigurator.instance
            .getConfig()
            ?.appBarConfig
            ?.merge(appBarConfig) ?? SsiAppBarConfig();

    if (brightness == Brightness.light) {
      _defaultConfig = _defaultConfig.merge(SsiAppBarConfig.light());
    } else if (brightness == Brightness.dark) {
      _defaultConfig = _defaultConfig.merge(SsiAppBarConfig.dark());
    }

    _defaultConfig.backgroundColor = backgroundColor;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        /// leading
        SsiBackLeading(
          iconPressed: backLeadCallback,
          themeData: _defaultConfig,
        ),

        /// divider
        Visibility(
          visible: showLeadingDivider ?? true,
          child: Container(
            margin: EdgeInsets.only(left: 12, right: 12),
            height: 16,
            width: 1,
            color: SsiThemeConfigurator.instance
                .getConfig()
                ?.commonConfig
                ?.dividerColorBase,
          ),
        ),

        /// padding
        Visibility(
          visible: !(showLeadingDivider ?? true),
          child: Padding(
            padding: EdgeInsets.only(left: 12),
          ),
        ),

        /// title
        Expanded(
          child: Text(
            title ?? '',
            style: _defaultConfig.titleStyle?.generateTextStyle(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20),
        )
      ],
    );
  }
}
