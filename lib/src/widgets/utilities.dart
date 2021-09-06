import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventory_management/src/model/resource.dart';
import '../size_config.dart';

kLongToast(String message, BuildContext context) => Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: Theme.of(context).backgroundColor,
      textColor: Theme.of(context).primaryColor,
      fontSize: getProportionateScreenHeight(20),
    );

kDeletePopup({Function function, BuildContext context, String title}) =>
    AwesomeDialog(
            context: context,
            dialogType: DialogType.INFO_REVERSED,
            headerAnimationLoop: false,
            animType: AnimType.SCALE,
            title: title,
            btnOkText: 'Yes',
            btnCancelText: 'No',
            btnOkColor: Theme.of(context).primaryColor,
            btnCancelColor: Theme.of(context).primaryColorLight,
            btnCancelOnPress: () {},
            btnOkOnPress: function)
        .show();

String getQuantityTypeString(Resource resource) {
  return resource.quantity.toString() +
      (resource.type.index == 0 ? ' L' : ' Kg');
}

String getQuantityTypeStringUsed(Resource resource) {
  return resource.totalUsed.toString() +
      (resource.type.index == 0 ? ' L' : ' Kg');
}
