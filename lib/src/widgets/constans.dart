import 'package:flutter/material.dart';

final kBorderRadius = BorderRadius.circular(5);
final kBorderRadiusLite = BorderRadius.circular(5);
final kInputFiledBorderRadius = BorderRadius.circular(35);
final kInputFiledBorderRadiusAdd = BorderRadius.circular(5);

final kAnimTypeLogin = Curves.easeIn;
final kAnimDurationLogin = Duration(milliseconds: 400);

//Box decorations
kBoxShadowLite(context) => BoxShadow(
      color: Theme.of(context).shadowColor.withOpacity(0.2),
      blurRadius: 5,
      spreadRadius: 2,
    );
kBoxShadow(context) => BoxShadow(
      color: Theme.of(context).shadowColor.withOpacity(0.5),
      blurRadius: 15,
      spreadRadius: 5,
    );

//Add products page
kOutlineBorderAdd(context) => OutlineInputBorder(
      borderRadius: kInputFiledBorderRadiusAdd,
      borderSide: BorderSide(color: Theme.of(context).accentColor),
    );
kEnabledOutlineBorderAdd(context) => OutlineInputBorder(
      borderRadius: kInputFiledBorderRadiusAdd,
      borderSide: BorderSide(color: Theme.of(context).accentColor),
    );
kErrorOutlineBorderAdd(context) => OutlineInputBorder(
      borderRadius: kInputFiledBorderRadiusAdd,
      borderSide: BorderSide(color: Theme.of(context).errorColor),
    );

kLoginBackgroundGradient(context) => LinearGradient(
      colors: [
        Theme.of(context).accentColor,
        Theme.of(context).primaryColorDark,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

kArrowButtonGradient(context) => LinearGradient(
      colors: [
        Theme.of(context).primaryColor,
        Theme.of(context).secondaryHeaderColor
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
