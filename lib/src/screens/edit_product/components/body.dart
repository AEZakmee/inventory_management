import 'package:flutter/material.dart';
import 'resourceRows.dart';
import '../../../widgets/input_field.dart';
import '../../../widgets/loading_button.dart';
import '../../../widgets/paddings.dart';
import '../../../widgets/text_widgets.dart';
import '../../../widgets/utilities.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../providers/edit_product_provider.dart';
import 'package:provider/provider.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _btnController = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Consumer<EditProductProvider>(
      builder: (context, prov, child) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(30),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  mediumPadding(),
                  editItemHeadlineText(
                      prov.isEdit
                          ? "Update product data"
                          : "Enter product data",
                      context),
                  CustomTextField(
                    textController: prov.nameController,
                    hintText: "Enter resource name",
                    label: "Resource Name",
                    onChanged: (v) => prov.setData(v, ProductField.Name),
                    errorString: prov.getError(ProductField.Name),
                    hasError: prov.hasError(ProductField.Name),
                  ),
                  AddResourceRow(),
                  smallPadding(),
                  PickedResourcesLV(
                    resources: prov.resources,
                  ),
                  smallPadding(),
                  if (prov.showErrorsString)
                    Padding(
                      padding: EdgeInsets.only(
                        top: getProportionateScreenHeight(5),
                      ),
                      child: editItemErrorText(prov.errorsString, context),
                    ),
                  smallPadding(),
                  LoadingButtonCustom(
                    controller: _btnController,
                    onPressed: () async {
                      bool success = await prov.saveProduct();
                      if (success) {
                        kLongToast('Product Saved', context);
                        Navigator.of(context).pop();
                      }
                      _btnController.reset();
                    },
                    text: prov.isEdit ? 'Update Product' : 'Add Product',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
