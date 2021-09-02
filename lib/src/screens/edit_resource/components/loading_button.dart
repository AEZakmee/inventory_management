import 'package:flutter/material.dart';
import '../../../providers/edit_resource_provider.dart';
import '../../../styles/colors.dart';
import '../../../styles/constans.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../size_config.dart';

class LoadingButtonCustom extends StatelessWidget {
  final RoundedLoadingButtonController controller;
  const LoadingButtonCustom({Key key, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      controller: controller,
      onPressed: () async {
        bool success =
            await Provider.of<EditResourceProvider>(context, listen: false)
                .saveProduct();
        if (success) {
          kLongToast('Product Saved');
          Navigator.of(context).pop();
        } else {
          controller.error();
          Future.delayed(Duration(seconds: 1));
        }
        controller.reset();
      },
      width: SizeConfig.screenWidth - getProportionateScreenWidth(60),
      borderRadius: getProportionateScreenHeight(5),
      color: kMainColor,
      child: Text(
        Provider.of<EditResourceProvider>(context).isEdit
            ? "Update resource"
            : "Save resource",
        style: TextStyle(
          color: kBackgroundColor,
          fontSize: getProportionateScreenHeight(20),
        ),
      ),
    );
  }
}
