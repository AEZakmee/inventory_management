import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../model/resource.dart';
import '../../../styles/colors.dart';
import '../../../styles/constans.dart';
import '../../../widgets/type_button.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
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
                "Update quantity",
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(30),
                  color: kMainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              CustomTextField(
                textController: prov.quantityController,
                field: ResourceField.Name,
                hintText: "Enter Quantity",
                label: "Quantity",
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TypeButtonAdd(value: -100),
                  TypeButtonAdd(value: -10),
                  TypeButtonAdd(value: -1),
                  TypeButtonAdd(value: 1),
                  TypeButtonAdd(value: 10),
                  TypeButtonAdd(value: 100),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: getProportionateScreenHeight(40),
                ),
                child: LoadingButtonCustom(
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
