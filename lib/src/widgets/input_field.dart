import 'package:flutter/material.dart';
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
                  color: hasError
                      ? Theme.of(context).errorColor
                      : Theme.of(context).primaryColor,
                  fontSize: getProportionateScreenHeight(17),
                ),
              ),
            ),
          TextField(
            controller: textController,
            onChanged: (v) => onChanged(v),
            showCursor: true,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: EdgeInsets.only(
                left: getProportionateScreenWidth(10),
              ),
              enabledBorder: hasError
                  ? kErrorOutlineBorderAdd(context)
                  : kOutlineBorderAdd(context),
              focusedBorder: hasError
                  ? kErrorOutlineBorderAdd(context)
                  : kEnabledOutlineBorderAdd(context),
            ),
          ),
        ],
      ),
    );
  }
}
