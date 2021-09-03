import 'package:flutter/material.dart';
import 'package:inventory_management/src/model/resource.dart';
import 'package:inventory_management/src/screens/edit_resource/components/input_field.dart';
import 'package:inventory_management/src/screens/edit_resource/components/loading_button.dart';
import 'package:inventory_management/src/styles/colors.dart';
import 'package:inventory_management/src/styles/constans.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../providers/edit_product_provider.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _btnControllerQuantity = RoundedLoadingButtonController();
  final _btnController = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Consumer<EditProductProvider>(builder: (context, prov, child) {
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(30),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Text(
                  prov.isEdit ? "Update product data" : "Enter product data",
                  style: TextStyle(
                    fontSize: getProportionateScreenHeight(30),
                    color: kMainColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CustomTextField(
                  textController: prov.nameController,
                  field: ProductField.Name,
                  hintText: "Enter resource name",
                  label: "Resource Name",
                  prov: prov,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: kBorderRadiusLite,
                          border: Border.all(color: kMainColorAccent),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(5),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<Resource>(
                              value: prov.selectedResource,
                              hint: Text('Pick resource'),
                              icon: Icon(Icons.arrow_downward),
                              iconSize: getProportionateScreenHeight(25),
                              elevation: 16,
                              style: TextStyle(
                                color: kMainColor,
                                fontSize: getProportionateScreenWidth(17),
                              ),
                              onChanged: (Resource newValue) {
                                prov.selectedResource = newValue;
                              },
                              items: prov.resourcesList,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(10),
                    ),
                    Expanded(
                      flex: 3,
                      child: CustomTextField(
                        textController: prov.quantityController,
                        field: ProductField.Quantity,
                        hintText: "Enter quantity",
                        label: "Quantity",
                        prov: prov,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          ...List.generate(
                            prov.resources.length,
                            (index) => Text(prov.resources[index].res.name),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(10),
                    ),
                    Expanded(
                      flex: 3,
                      child: LoadingButtonCustom(
                        controller: _btnControllerQuantity,
                        onPressed: () {
                          prov.appendResource();
                          _btnControllerQuantity.reset();
                        },
                        text: 'Add Resource',
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
                if (prov.showErrorsString)
                  Padding(
                    padding: EdgeInsets.only(
                      top: getProportionateScreenHeight(5),
                    ),
                    child: Text(
                      prov.errorsString,
                      style: TextStyle(
                        color: kErrorColor,
                        fontSize: getProportionateScreenHeight(16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                AnimatedContainer(
                  duration: kAnimDurationLogin,
                  curve: kAnimTypeLogin,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: getProportionateScreenHeight(10),
                    ),
                    child: LoadingButtonCustom(
                      controller: _btnController,
                      onPressed: () async {
                        bool success = await prov.saveProduct();
                        if (success) {
                          kLongToast('Product Saved');
                          Navigator.of(context).pop();
                        }
                        _btnController.reset();
                      },
                      text: prov.isEdit ? 'Update Product' : 'Add Product',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
