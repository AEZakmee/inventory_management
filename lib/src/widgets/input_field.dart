import 'package:flutter/material.dart';
import '../styles/colors.dart';
import 'constans.dart';
import '../size_config.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key key,
    @required this.textController,
    this.hintText = "",
    this.label,
    @required this.onChanged,
    @required this.hasError,
    @required this.errorString,
  }) : super(key: key);
  final textController;
  final String hintText;
  final String label;
  final bool hasError;
  final String errorString;
  final Function onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: getProportionateScreenHeight(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Padding(
              padding: EdgeInsets.only(
                bottom: getProportionateScreenHeight(3),
              ),
              child: Text(
                hasError ? errorString : label,
                style: TextStyle(
                  color: hasError ? kErrorColor : kMainColor,
                  fontSize: getProportionateScreenHeight(17),
                ),
              ),
            ),
          TextField(
            controller: textController,
            onChanged: (v) => onChanged(v),
            showCursor: true,
            cursorColor: kMainColor,
            style: TextStyle(
              color: kMainColor,
              fontSize: getProportionateScreenHeight(22),
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: getProportionateScreenHeight(18),
                color: kTextColor,
              ),
              contentPadding: EdgeInsets.only(
                left: getProportionateScreenWidth(10),
              ),
              enabledBorder:
                  hasError ? kErrorOutlineBorderAdd : kOutlineBorderAdd,
              focusedBorder:
                  hasError ? kErrorOutlineBorderAdd : kEnabledOutlineBorderAdd,
            ),
          ),
        ],
      ),
    );
  }
}
