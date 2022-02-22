import 'package:flutter/material.dart';
import 'package:flutter_ssikit/src/components/button/ssi_normal_button.dart';
import 'package:flutter_ssikit/src/theme/configs/ssi_button_config.dart';

import '../../../flutter_ssikit.dart';

/// 页面中的主按钮,支持动态设置背景颜色，置灰
///
/// 和[SsiSmallMainButton]相比，该按钮是占据父节点分配的最大可用空间，按钮文案居中对齐
///
/// 按钮是圆角矩形的形状，不支持改变形状。
///
/// 按钮也存在可用和不可用两种状态，[isEnable]如果设置为false，那么按钮呈现灰色态，点击事件不响应
///
/// 大的 提交 按钮
/// SsiBigMainButtonWidget(
///    title: '提交',
/// )
///
/// SsiBigMainButtonWidget(
///   title: '提交',
///   isEnable: false,
///   onTap: () {
///     SsiToast.show('点击了主按钮', context);
///   },
/// ),

/// 其他按钮如下：
///  * [SsiBigGhostButton], 大主色调的幽灵按钮
///  * [SsiBigOutlineButton], 大边框按钮

/// 默认水平间距
const double _BHorizontalPadding = 16;

/// 默认垂直间距
const double _BVerticalPadding = 8;

class SsiBigMainButton extends StatelessWidget {
  ///按钮显示文案,默认'确认'
  final String title;

  ///是否可用,false 是置灰效果
  final bool isEnable;

  ///点击回调
  final VoidCallback? onTap;

  ///默认父布局可用空间
  final double? width;

  ///背景颜色
  final Color? bgColor;

  final SsiButtonConfig? themeData;

  const SsiBigMainButton({
    Key? key,
    this.title = '确认',
    this.width,
    this.isEnable = true,
    this.themeData,
    this.onTap,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SsiButtonConfig defaultThemeConfig = themeData ?? SsiButtonConfig();

    defaultThemeConfig = SsiThemeConfigurator.instance
        .getConfig(configId: defaultThemeConfig.configId)!
        .buttonConfig!
        .merge(defaultThemeConfig);

    return SsiNormalButton(
      constraints: BoxConstraints.tightFor(
          width: width ?? double.infinity,
          height: defaultThemeConfig.bigButtonHeight),
      alignment: Alignment.center,
      isEnable: isEnable,
      text: title,
      backgroundColor:
          bgColor ?? defaultThemeConfig.commonConfig!.brandPrimary!,
      disableBackgroundColor: const Color(0xFFCCCCCC),
      onTap: onTap,
      textColor: Colors.white,
      disableTextColor: defaultThemeConfig.commonConfig!.colorTextBaseInverse!
          .withOpacity(0.7),
      insertPadding: const EdgeInsets.symmetric(
          horizontal: _BHorizontalPadding, vertical: _BVerticalPadding),
    );
  }
}
