import 'package:flutter/material.dart';
import 'package:inventory_management/src/providers/edit_resource_provider.dart';
import 'package:provider/provider.dart';
import '../styles/colors.dart';
import '../styles/constans.dart';
import '../size_config.dart';

class TypeButton extends StatelessWidget {
  const TypeButton({
    Key key,
    @required this.isClicked,
    @required this.text,
    this.onClicked,
  }) : super(key: key);
  final bool isClicked;
  final String text;
  final Function onClicked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClicked,
      child: Container(
        height: getProportionateScreenHeight(35),
        width: getProportionateScreenWidth(150),
        decoration: BoxDecoration(
          color: isClicked ? kMainColor : kMainColorLight,
          borderRadius: kInputFiledBorderRadiusAdd,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isClicked ? kBackgroundColor : kMainColor,
              fontSize: getProportionateScreenHeight(20),
            ),
          ),
        ),
      ),
    );
  }
}

class TypeButtonAdd extends StatelessWidget {
  const TypeButtonAdd({
    Key key,
    @required this.value,
  }) : super(key: key);
  final int value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<EditResourceProvider>(context, listen: false)
            .addQuantity(value);
      },
      child: Container(
        height: getProportionateScreenHeight(35),
        width: getProportionateScreenWidth(50),
        decoration: BoxDecoration(
          color: value < 0 ? kMainColorLight : kMainColorAccent,
          borderRadius: kInputFiledBorderRadiusAdd,
        ),
        child: Center(
          child: Text(
            value.toString(),
            style: TextStyle(
                color: value < 0 ? kMainColor : kBackgroundColor,
                fontSize: getProportionateScreenHeight(20),
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
