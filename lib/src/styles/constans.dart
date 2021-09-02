import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../size_config.dart';
import 'colors.dart';

final kBorderRadius = BorderRadius.circular(15);
final kBorderRadiusLite = BorderRadius.circular(5);
final kInputFiledBorderRadius = BorderRadius.circular(35);
final kInputFiledBorderRadiusAdd = BorderRadius.circular(5);

final kAnimTypeLogin = Curves.easeIn;
final kAnimDurationLogin = Duration(milliseconds: 400);

//Box decorations
final kBoxShadowLite = BoxShadow(
  color: Colors.black.withOpacity(0.2),
  blurRadius: 5,
  spreadRadius: 2,
);
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
  borderSide: BorderSide(color: kMainColor),
);

//Add products page
final kOutlineBorderAdd = OutlineInputBorder(
  borderRadius: kInputFiledBorderRadiusAdd,
  borderSide: BorderSide(color: kMainColorAccent),
);
final kEnabledOutlineBorderAdd = OutlineInputBorder(
  borderRadius: kInputFiledBorderRadiusAdd,
  borderSide: BorderSide(color: kMainColor),
);
final kErrorOutlineBorderAdd = OutlineInputBorder(
  borderRadius: kInputFiledBorderRadiusAdd,
  borderSide: BorderSide(color: kErrorColor),
);

kLongToast(String message) => Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.white60,
      textColor: kMainColor,
      fontSize: getProportionateScreenHeight(20),
    );
