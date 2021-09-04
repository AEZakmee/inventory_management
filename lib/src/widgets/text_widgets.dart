import 'package:flutter/material.dart';
import '../styles/colors.dart';
import '../size_config.dart';

Widget headlineText({String text = ''}) => Text(
      text,
      style: TextStyle(
        fontSize: getProportionateScreenWidth(30),
        color: kMainColor,
        fontWeight: FontWeight.bold,
      ),
    );

Widget editItemErrorText({String text = ''}) => Text(
      text,
      style: TextStyle(
        color: kErrorColor,
        fontSize: getProportionateScreenWidth(15),
        fontWeight: FontWeight.bold,
      ),
    );

Widget buttonText(
        {String text = '',
        double fontSize,
        FontWeight fontWeight,
        Color color}) =>
    Text(
      text,
      style: TextStyle(
          fontWeight: fontWeight ?? FontWeight.w500,
          fontSize: fontSize ?? getProportionateScreenWidth(20),
          color: color ?? kBackgroundColor),
    );
