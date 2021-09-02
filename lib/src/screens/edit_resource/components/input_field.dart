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
    this.label,
  }) : super(key: key);
  final textController;
  final ResourceField field;
  final String hintText;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Consumer<ResourceProvider>(
      builder: (context, prov, child) {
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
                    prov.hasError(field) ? prov.getError(field) : label,
                    style: TextStyle(
                      color: prov.hasError(field) ? kErrorColor : kMainColor,
                      fontSize: getProportionateScreenHeight(17),
                    ),
                  ),
                ),
              TextField(
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
                  enabledBorder: prov.hasError(field)
                      ? kErrorOutlineBorderAdd
                      : kOutlineBorderAdd,
                  focusedBorder: prov.hasError(field)
                      ? kErrorOutlineBorderAdd
                      : kEnabledOutlineBorderAdd,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
