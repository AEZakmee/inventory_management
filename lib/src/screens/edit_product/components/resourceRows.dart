import 'package:flutter/material.dart';
import 'package:inventory_management/src/model/product.dart';
import 'package:inventory_management/src/widgets/loading_button.dart';
import 'package:inventory_management/src/widgets/utilities.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../model/resource.dart';
import '../../../styles/colors.dart';
import '../../../widgets/constans.dart';
import '../../../widgets/input_field.dart';
import '../../../widgets/paddings.dart';
import '../../../providers/edit_product_provider.dart';
import 'package:provider/provider.dart';
import '../../../size_config.dart';

class PickedResourcesLV extends StatefulWidget {
  const PickedResourcesLV({
    @required this.resources,
  });
  final List<ItemQuantity> resources;

  @override
  _PickedResourcesLVState createState() => _PickedResourcesLVState();
}

class _PickedResourcesLVState extends State<PickedResourcesLV> {
  final _btnControllerQuantity = RoundedLoadingButtonController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<EditProductProvider>(context, listen: false);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Container(
            height: 135,
            child: AnimatedList(
              key: _listKey,
              initialItemCount: widget.resources.length,
              itemBuilder: (context, index, animation) => _buildItem(
                  context, widget.resources[index], animation, index),
            ),
          ),
        ),
        smallPadding(isVertical: true),
        Expanded(
          flex: 3,
          child: LoadingButtonCustom(
            controller: _btnControllerQuantity,
            onPressed: () {
              bool appended = prov.appendResource();
              if (appended) _listKey.currentState.insertItem(0);
              _btnControllerQuantity.reset();
            },
            text: 'Add Resource',
          ),
        )
      ],
    );
  }

  Widget _buildItem(BuildContext context, ItemQuantity item,
      Animation<double> animation, int index) {
    final prov = Provider.of<EditProductProvider>(context, listen: false);
    return ScaleTransition(
      child: GestureDetector(
        onLongPress: () {
          kDeletePopup(
              function: () {
                _listKey.currentState.removeItem(
                  index,
                  (BuildContext context, Animation<double> animation) =>
                      prov.resources.length != index
                          ? _buildItem(context, widget.resources[index],
                              animation, index)
                          : null,
                  duration: const Duration(milliseconds: 250),
                );
                prov.deleteResource(index);
              },
              title: 'Do you intent to remove ${item.res.name}?',
              context: context);
        },
        child: Card(
          color: item.isValid ? kMainColorLight : kErrorColor,
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(
              kMiniPadding,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: getProportionateScreenWidth(110),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      item.res.name,
                      style: TextStyle(
                        color: kMainColor,
                        fontWeight: FontWeight.w400,
                        fontSize: getProportionateScreenWidth(16),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  getQuantityTypeString(item.res),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      scale: animation,
    );
  }
}

class AddResourceRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<EditProductProvider>(
      builder: (context, prov, child) {
        return Row(
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
                    horizontal: kMiniPadding,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<Resource>(
                      value: prov.selectedResource,
                      hint: Text('Pick resource'),
                      icon: Icon(Icons.arrow_downward),
                      iconSize: getProportionateScreenWidth(25),
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
            smallPadding(isVertical: true),
            Expanded(
              flex: 3,
              child: CustomTextField(
                textController: prov.quantityController,
                hintText: "Enter quantity",
                label: "Quantity",
                onChanged: (v) => prov.setData(v, ProductField.Quantity),
                errorString: prov.getError(ProductField.Quantity),
                hasError: prov.hasError(ProductField.Quantity),
              ),
            ),
          ],
        );
      },
    );
  }
}
