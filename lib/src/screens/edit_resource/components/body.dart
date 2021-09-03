import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/src/styles/constans.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../model/resource.dart';
import '../../../styles/colors.dart';
import '../../../widgets/type_button.dart';
import '../../../providers/edit_resource_provider.dart';
import 'package:provider/provider.dart';
import '../../../size_config.dart';
import 'input_field.dart';
import 'loading_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _btnController = RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return Consumer<EditResourceProvider>(builder: (context, prov, child) {
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(30),
          ),
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Text(
                prov.isEdit ? "Update resource data" : "Enter resource data",
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(30),
                  color: kMainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomTextField(
                textController: prov.nameController,
                field: ResourceField.Name,
                hintText: "Enter resource name",
                label: "Resource Name",
                prov: prov,
              ),
              CustomTextField(
                textController: prov.quantityController,
                field: ResourceField.Quantity,
                hintText: "Enter quantity",
                label: "Quantity",
                prov: prov,
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              Row(
                children: [
                  TypeButton(
                    text: 'Kilos',
                    isClicked: prov.resourceType == ResourceType.Kilos,
                    onClicked: () => prov.resourceType = ResourceType.Kilos,
                  ),
                  Spacer(),
                  TypeButton(
                    text: 'Litres',
                    isClicked: prov.resourceType == ResourceType.Litres,
                    onClicked: () => prov.resourceType = ResourceType.Litres,
                  ),
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
              Padding(
                padding: EdgeInsets.only(
                  top: getProportionateScreenHeight(10),
                ),
                child: LoadingButtonCustom(
                  text: Provider.of<EditResourceProvider>(context).isEdit
                      ? "Update resource"
                      : "Save resource",
                  onPressed: () async {
                    bool success = await prov.saveProduct();
                    if (success) {
                      kLongToast('Product Saved');
                      Navigator.of(context).pop();
                    }
                    _btnController.reset();
                  },
                  controller: _btnController,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
