import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import '../model/resource.dart';
import '../model/product.dart';
import '../providers/user_provider.dart';
import '../size_config.dart';
import '../widgets/loading_button.dart';
import '../widgets/paddings.dart';
import '../widgets/text_widgets.dart';
import '../widgets/utilities.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class BottomSheetCustomProduct extends StatefulWidget {
  const BottomSheetCustomProduct({Key key, this.product}) : super(key: key);
  final Product product;

  @override
  _BottomSheetCustomProductState createState() =>
      _BottomSheetCustomProductState();
}

class _BottomSheetCustomProductState extends State<BottomSheetCustomProduct> {
  double _value = 0;
  double total;
  final _btnController = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: Provider.of<UserProvider>(context).getMaxProducts(widget.product),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center();
        }
        _value = (snapshot.data ~/ 10).toDouble();
        total = _value;
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: getProportionateScreenHeight(20),
            ),
            child: Column(
              children: [
                cardHeadlineBig('Enter Quantity', context),
                bigPadding(),
                Row(
                  children: [
                    Text(
                      'Max: ' + snapshot.data.toString(),
                      style: Theme.of(context).textTheme.headline6.copyWith(
                            fontSize: getProportionateScreenWidth(20),
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ],
                ),
                smallPadding(),
                SpinBox(
                  value: _value,
                  max: snapshot.data.toDouble(),
                  min: 0,
                  decimals: 0,
                  validator: (text) {
                    double quantity;
                    try {
                      quantity = double.parse(text);
                      if (quantity <= 0) {
                        return 'Enter Valid Value';
                      }
                      total = quantity;
                    } on Exception {
                      return 'Enter Valid Value';
                    }
                    return quantity <= 0 ? 'Enter Valid Value' : null;
                  },
                  textStyle: TextStyle(fontSize: 30),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(fontSize: 25),
                  ),
                  onChanged: (value) => total = value,
                  incrementIcon: Icon(
                    Icons.add,
                    size: 40,
                  ),
                  decrementIcon: Icon(
                    Icons.remove,
                    size: 40,
                  ),
                ),
                bigPadding(),
                bigPadding(),
                LoadingButtonCustom(
                    controller: _btnController,
                    text: 'Proceed Product',
                    onPressed: () async {
                      if (total <=
                          await Provider.of<UserProvider>(context,
                                  listen: false)
                              .getMaxProducts(widget.product)) {
                        //ask for permission
                        kInfoPopup(
                          context: context,
                          title: 'Please check if everything is correct!',
                          text: getStringOrder(widget.product, total),
                          function: () async {
                            await Provider.of<UserProvider>(context,
                                    listen: false)
                                .proceedOrder(widget.product, total.toInt());
                            kLongToast('Product proceed successfully', context);
                            Navigator.of(context).pop();
                          },
                        );
                      } else {
                        kLongToast('Error proceeding the product', context);
                      }
                      _btnController.reset();
                    }),
                SizedBox(
                  height: getProportionateScreenHeight(100),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BottomSheetCustomResource extends StatefulWidget {
  const BottomSheetCustomResource({Key key, this.resource}) : super(key: key);
  final Resource resource;

  @override
  _BottomSheetCustomResourceState createState() =>
      _BottomSheetCustomResourceState();
}

class _BottomSheetCustomResourceState extends State<BottomSheetCustomResource> {
  double total = 100;
  final _btnController = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenHeight(20),
        ),
        child: Column(
          children: [
            cardHeadlineBig('Enter Quantity', context),
            bigPadding(),
            SpinBox(
              value: total,
              max: 100000,
              min: 0,
              decimals: 0,
              validator: (text) {
                double quantity;
                try {
                  quantity = double.parse(text);
                  if (quantity <= 0) {
                    return 'Enter Valid Value';
                  }
                  total = quantity;
                } on Exception {
                  return 'Enter Valid Value';
                }
                return quantity <= 0 ? 'Enter Valid Value' : null;
              },
              textStyle: TextStyle(fontSize: 30),
              decoration: InputDecoration(
                errorStyle: TextStyle(fontSize: 25),
              ),
              onChanged: (value) => total = value,
              incrementIcon: Icon(
                Icons.add,
                size: 40,
              ),
              decrementIcon: Icon(
                Icons.remove,
                size: 40,
              ),
            ),
            bigPadding(),
            bigPadding(),
            LoadingButtonCustom(
                controller: _btnController,
                text: 'Top Up Resource',
                onPressed: () async {
                  await Provider.of<UserProvider>(context, listen: false)
                      .topUpResource(widget.resource, total.toInt());
                  kLongToast('Top up success', context);
                  Navigator.of(context).pop();
                  _btnController.reset();
                }),
            SizedBox(
              height: getProportionateScreenHeight(100),
            ),
          ],
        ),
      ),
    );
  }
}
