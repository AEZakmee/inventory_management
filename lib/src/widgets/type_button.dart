import 'package:flutter/material.dart';
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
