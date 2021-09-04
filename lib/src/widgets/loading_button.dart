import 'package:flutter/material.dart';
import '../styles/colors.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../size_config.dart';

class LoadingButtonCustom extends StatelessWidget {
  final RoundedLoadingButtonController controller;
  final Function onPressed;
  final String text;
  const LoadingButtonCustom(
      {Key key, @required this.controller, @required this.onPressed, this.text})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      controller: controller,
      onPressed: onPressed,
      width: SizeConfig.screenWidth - getProportionateScreenWidth(60),
      borderRadius: getProportionateScreenHeight(5),
      color: kMainColor,
      child: Text(
        text,
        style: TextStyle(
          color: kBackgroundColor,
          fontSize: getProportionateScreenHeight(20),
        ),
      ),
    );
  }
}
