import 'package:flutter/material.dart';
import '../../../widgets/loading_widget.dart';
import '../../../providers/resources_provider.dart';
import 'package:provider/provider.dart';
import '../../../size_config.dart';
import 'input_field.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    _loadResource();
    super.initState();
  }

  void _loadResource() async {
    await Provider.of<ResourceProvider>(context, listen: false).loadProduct();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      hasLoadingError: Provider.of<ResourceProvider>(context).hasLoadingError,
      isLoading: Provider.of<ResourceProvider>(context).isLoading,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(30),
          ),
          child: Column(
            children: [
              CustomTextField(
                textController:
                    Provider.of<ResourceProvider>(context, listen: false)
                        .nameController,
                field: ResourceField.Name,
                hintText: "Enter resource name",
              ),
              CustomTextField(
                textController:
                    Provider.of<ResourceProvider>(context, listen: false)
                        .quantityController,
                field: ResourceField.Quantity,
                hintText: "Enter quantity",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
