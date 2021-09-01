import 'package:flutter/material.dart';
import '../../../providers/resources_provider.dart';
import '../../../styles/colors.dart';
import '../../../styles/constans.dart';
import 'package:provider/provider.dart';
import '../../../size_config.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key key,
    @required this.textController,
    @required this.field,
    this.hintText = "",
  }) : super(key: key);
  final textController;
  final ResourceField field;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Consumer<ResourceProvider>(builder: (context, prov, child) {
      return Padding(
        padding: EdgeInsets.only(
          top: getProportionateScreenHeight(20),
        ),
        child: TextField(
          controller: textController,
          onChanged: (value) => prov.setData(value, field),
          showCursor: true,
          cursorColor: kMainColor,
          style: TextStyle(
            color: kMainColor,
            fontSize: getProportionateScreenHeight(22),
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: getProportionateScreenHeight(20),
              color: kTextColor,
            ),
            contentPadding: EdgeInsets.only(
              left: getProportionateScreenWidth(10),
            ),
            enabledBorder: kOutlineBorderAdd,
            focusedBorder: kEnabledOutlineBorderAdd,
            errorText: prov.hasError(field) ? prov.getError(field) : null,
          ),
        ),
      );
    });
  }
}
