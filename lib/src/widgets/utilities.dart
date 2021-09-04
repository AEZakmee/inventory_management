import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventory_management/src/model/resource.dart';
import 'package:inventory_management/src/styles/colors.dart';
import '../size_config.dart';

kLongToast(String message) => Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: kMainColorLight,
      textColor: kMainColor,
      fontSize: getProportionateScreenHeight(20),
    );

kDeletePopup({Function function, context, String title}) => AwesomeDialog(
        context: context,
        dialogType: DialogType.INFO_REVERSED,
        headerAnimationLoop: false,
        animType: AnimType.SCALE,
        title: title,
        btnOkText: 'Yes',
        btnCancelText: 'No',
        btnOkColor: kMainColorAccent,
        btnCancelColor: kMainColorLight,
        btnCancelOnPress: () {},
        btnOkOnPress: function)
    .show();

String getQuantityTypeString(Resource resource) {
  return resource.quantity.toString() +
      (resource.type.index == 0 ? ' L' : ' Kg');
}
