import 'package:flutter/material.dart';
import 'constans.dart';
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
          color: isClicked
              ? Theme.of(context).buttonColor
              : Theme.of(context).disabledColor,
          borderRadius: kInputFiledBorderRadiusAdd,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isClicked
                  ? Theme.of(context).buttonTheme.colorScheme.onPrimary
                  : Theme.of(context).buttonTheme.colorScheme.onBackground,
              fontSize: getProportionateScreenHeight(18),
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
    @required this.onTap,
  }) : super(key: key);
  final int value;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: getProportionateScreenHeight(35),
        width: getProportionateScreenWidth(50),
        decoration: BoxDecoration(
          color: value < 0
              ? Theme.of(context).accentColor
              : Theme.of(context).primaryColorLight,
          borderRadius: kInputFiledBorderRadiusAdd,
        ),
        child: Center(
          child: Text(
            value < 0 ? value.toString() : '+$value',
            style: TextStyle(
                color: value < 0
                    ? Theme.of(context).buttonTheme.colorScheme.onPrimary
                    : Theme.of(context).buttonTheme.colorScheme.onBackground,
                fontSize: getProportionateScreenHeight(20),
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
