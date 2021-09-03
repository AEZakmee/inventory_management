import 'package:flutter/material.dart';
import '../../../providers/edit_resource_provider.dart';
import '../../../styles/colors.dart';
import '../../../styles/constans.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../size_config.dart';

class LoadingButtonCustom extends StatelessWidget {
  final RoundedLoadingButtonController controller;
  final double width;
  final Function onPressed;
  final String text;
  const LoadingButtonCustom(
      {Key key,
      @required this.controller,
      this.width,
      @required this.onPressed,
      this.text})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      controller: controller,
      onPressed: onPressed,
      width: width ?? SizeConfig.screenWidth - getProportionateScreenWidth(60),
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
