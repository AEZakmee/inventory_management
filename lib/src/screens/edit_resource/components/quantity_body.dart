import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../widgets/paddings.dart';
import '../../../widgets/text_widgets.dart';
import '../../../widgets/utilities.dart';
import '../../../widgets/type_button.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../providers/edit_resource_provider.dart';
import 'package:provider/provider.dart';
import '../../../widgets/input_field.dart';
import '../../../widgets/loading_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _btnController = RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return Consumer<EditResourceProvider>(
      builder: (context, prov, child) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: kBigPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                mediumPadding(),
                headlineText(text: 'Update quantity'),
                bigPadding(),
                CustomTextField(
                  textController: prov.quantityController,
                  hintText: "Enter Quantity",
                  label: "Quantity",
                  onChanged: (v) => prov.setData(v, ResourceField.Name),
                  errorString: prov.getError(ResourceField.Name),
                  hasError: prov.hasError(ResourceField.Name),
                ),
                smallPadding(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TypeButtonAdd(
                      value: -100,
                      onTap: () => prov.addQuantity(-100),
                    ),
                    TypeButtonAdd(
                      value: -10,
                      onTap: () => prov.addQuantity(-10),
                    ),
                    TypeButtonAdd(
                      value: -1,
                      onTap: () => prov.addQuantity(-1),
                    ),
                    TypeButtonAdd(
                      value: 1,
                      onTap: () => prov.addQuantity(1),
                    ),
                    TypeButtonAdd(
                      value: 10,
                      onTap: () => prov.addQuantity(10),
                    ),
                    TypeButtonAdd(
                      value: 100,
                      onTap: () => prov.addQuantity(100),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: kHugePadding,
                  ),
                  child: LoadingButtonCustom(
                    controller: _btnController,
                    text: 'Update quantity',
                    onPressed: () async {
                      bool success = await prov.saveProduct();
                      if (success) {
                        kLongToast('Product Saved');
                        Navigator.of(context).pop();
                      }
                      _btnController.reset();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
