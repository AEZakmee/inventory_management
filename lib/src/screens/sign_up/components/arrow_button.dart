import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';
import '../../../styles/colors.dart';
import '../../../widgets/constans.dart';
import '../../../providers/login_provider.dart';

class ArrowButtonBackground extends StatelessWidget {
  const ArrowButtonBackground(
      {Key key, this.hasShadow = false, this.child, this.bottom = 0})
      : super(key: key);
  final bool hasShadow;
  final Widget child;
  final double bottom;
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: kAnimDurationLogin,
      curve: kAnimTypeLogin,
      right: 0,
      left: 0,
      bottom: bottom,
      child: Center(
        child: Container(
          height: getProportionateScreenHeight(105),
          width: getProportionateScreenHeight(105),
          decoration: BoxDecoration(
            color: kBackgroundColor,
            shape: BoxShape.circle,
            boxShadow: [if (hasShadow) kBoxShadow],
          ),
          child: Padding(
            padding: EdgeInsets.all(
              getProportionateScreenHeight(15),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class ArrowButton extends StatelessWidget {
  const ArrowButton({
    Key key,
    this.onPress,
  }) : super(key: key);
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          gradient: kArrowButtonGradient,
          boxShadow: [kBoxShadow],
          shape: BoxShape.circle,
        ),
        child: !Provider.of<LoginProvider>(context).isLoading
            ? Icon(
                Icons.arrow_forward,
                color: kBackgroundColor,
                size: getProportionateScreenHeight(40),
              )
            : Padding(
                padding: EdgeInsets.all(getProportionateScreenHeight(10)),
                child: SpinKitFadingCircle(
                  color: kBackgroundColor,
                ),
              ),
      ),
    );
  }
}
