import 'package:flutter/material.dart';
import '../size_config.dart';

AppBar buildAppBar({String title = "", @required context}) {
  return AppBar(
    centerTitle: true,
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios),
      iconSize: getProportionateScreenHeight(30),
      padding: EdgeInsets.only(left: 10),
      onPressed: () => Navigator.of(context).pop(),
    ),
    title: Text(
      title,
    ),
    elevation: 10,
  );
}
