import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../widgets/paddings.dart';
import '../../../widgets/text_widgets.dart';
import '../../../widgets/utilities.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../model/resource.dart';
import '../../../widgets/type_button.dart';
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
              children: [
                mediumPadding(),
                Text(
                  prov.isEdit ? "Update resource data" : "Enter resource data",
                  style: Theme.of(context).textTheme.headline4,
                ),
                CustomTextField(
                  textController: prov.nameController,
                  hintText: "Enter resource name",
                  label: "Resource Name",
                  onChanged: (v) => prov.setData(v, ResourceField.Name),
                  errorString: prov.getError(ResourceField.Name),
                  hasError: prov.hasError(ResourceField.Name),
                ),
                CustomTextField(
                  textController: prov.quantityController,
                  hintText: "Enter quantity",
                  label: "Quantity",
                  onChanged: (v) => prov.setData(v, ResourceField.Quantity),
                  errorString: prov.getError(ResourceField.Quantity),
                  hasError: prov.hasError(ResourceField.Quantity),
                ),
                smallPadding(),
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
                bigPadding(),
                if (prov.showErrorsString)
                  Padding(
                    padding: EdgeInsets.only(
                      top: kMiniPadding,
                    ),
                    child: editItemErrorText(prov.errorsString, context),
                  ),
                smallPadding(),
                LoadingButtonCustom(
                  controller: _btnController,
                  text: prov.isEdit ? "Update resource" : "Save resource",
                  onPressed: () async {
                    bool success = await prov.saveProduct();
                    if (success) {
                      kLongToast('Product Saved', context);
                      Navigator.of(context).pop();
                    }
                    _btnController.reset();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
