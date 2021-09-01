import 'package:flutter/material.dart';
import '../size_config.dart';
import '../styles/colors.dart';

AppBar buildAppBar({String title = "", @required context}) {
  return AppBar(
    backgroundColor: kBackgroundColor,
    centerTitle: true,
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios, color: kMainColor),
      iconSize: getProportionateScreenHeight(30),
      padding: EdgeInsets.only(left: 10),
      onPressed: () => Navigator.of(context).pop(),
    ),
    title: Text(
      title,
      style: TextStyle(
        color: kMainColor,
        fontSize: getProportionateScreenWidth(20),
        fontWeight: FontWeight.w700,
      ),
    ),
    elevation: 10,
  );
}
