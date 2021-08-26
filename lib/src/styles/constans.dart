import 'package:flutter/material.dart';
import 'colors.dart';

final kBorderRadius = BorderRadius.circular(15);
final kInputFiledBorderRadius = BorderRadius.circular(35);

final kAnimTypeLogin = Curves.easeIn;
final kAnimDurationLogin = Duration(milliseconds: 400);

//Box decorations
final kBoxShadow = BoxShadow(
  color: Colors.black.withOpacity(0.3),
  blurRadius: 15,
  spreadRadius: 5,
);
final kBoxDecoration = BoxDecoration(
  color: kBackgroundColor,
  borderRadius: kBorderRadius,
  boxShadow: [kBoxShadow],
);

//Text decorations
final kLoginClickedButtonStyle = TextStyle(
  fontSize: 21,
  fontWeight: FontWeight.bold,
  color: kMainColor,
);
final kLoginButtonStyle = TextStyle(
  fontSize: 21,
  fontWeight: FontWeight.bold,
  color: kTextColor,
);

//Text field decorations
final kOutlineBorder = OutlineInputBorder(
  borderRadius: kInputFiledBorderRadius,
  borderSide: BorderSide(color: kMainColorAccent),
);
final kErrorOutlineBorder = OutlineInputBorder(
  borderRadius: kInputFiledBorderRadius,
  borderSide: BorderSide(color: kErrorColor),
);
final kEnabledOutlineBorder = OutlineInputBorder(
  borderRadius: kInputFiledBorderRadius,
  borderSide: BorderSide(color: kMainColorAccent),
);
