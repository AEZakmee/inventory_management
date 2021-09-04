import 'package:flutter/material.dart';

import '../size_config.dart';

final kMiniPadding = getProportionateScreenHeight(5);
final kSmallPadding = getProportionateScreenHeight(10);
final kMediumPadding = getProportionateScreenHeight(20);
final kBigPadding = getProportionateScreenHeight(30);
final kHugePadding = getProportionateScreenHeight(40);
Widget smallPadding({bool isVertical = false}) => isVertical
    ? SizedBox(
        width: getProportionateScreenWidth(10),
      )
    : SizedBox(
        height: getProportionateScreenHeight(10),
      );
Widget mediumPadding() => SizedBox(
      height: getProportionateScreenHeight(20),
    );
Widget bigPadding() => SizedBox(
      height: getProportionateScreenHeight(30),
    );
