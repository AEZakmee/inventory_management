import 'package:flutter/material.dart';
import 'package:inventory_management/src/model/product.dart';
import 'package:inventory_management/src/providers/products_provider.dart';
import 'package:inventory_management/src/providers/user_provider.dart';
import 'package:inventory_management/src/screens/edit_product/edit_product_screen.dart';

import 'package:inventory_management/src/size_config.dart';
import 'package:inventory_management/src/styles/colors.dart';
import 'package:inventory_management/src/widgets/constans.dart';
import 'package:inventory_management/src/widgets/pass_argument.dart';
import 'package:inventory_management/src/widgets/type_button.dart';
import 'package:inventory_management/src/widgets/utilities.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
        stream: Provider.of<UserProvider>(context).listProducts,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: getProportionateScreenHeight(10),
                bottom: getProportionateScreenHeight(100),
              ),
              child: Container(
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.spaceAround,
                  children: [
                    ...List.generate(
                      snapshot.data.length,
                      (index) => Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(10),
                          vertical: getProportionateScreenHeight(10),
                        ),
                        child: ProductContainer(
                          product: snapshot.data[index],
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

class ProductContainer extends StatelessWidget {
  final Product product;
  const ProductContainer({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        kDeletePopup(
          context: context,
          title: 'You are about to delete ${product.name}!\nAre you sure?',
          function: () {
            Provider.of<ProductsProvider>(context, listen: false)
                .deleteProduct(product.uniqueID);
          },
        );
      },
      child: Container(
        width: getProportionateScreenWidth(165),
        decoration: BoxDecoration(
          color: kBackgroundColor,
          borderRadius: kBorderRadiusLite,
          boxShadow: [kBoxShadowLite],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10),
          ),
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(10),
                width: double.infinity,
              ),
              Text(
                product.name,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(20),
                  fontWeight: FontWeight.bold,
                  color: kMainColor,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(15),
              ),
              Row(
                children: [
                  Text(
                    'Required resources',
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(14),
                      fontWeight: FontWeight.w300,
                      color: kTextColor,
                    ),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              ...List.generate(
                product.resources.length,
                (i) => buildResRow(
                  itemQuantity: product.resources[i],
                  isValid: product.resources[i].isValid,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    color: kMainColor,
                    icon: Icon(Icons.edit),
                    iconSize: getProportionateScreenHeight(35),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        EditProductScreen.routeName,
                        arguments: ScreenArgumentsProduct(product),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildResRow({ItemQuantity itemQuantity, bool isValid}) {
    return Row(
      children: [
        Text(
          itemQuantity.res.name,
          style: TextStyle(
            color: isValid ? kMainColorAccent : kErrorColor,
          ),
        ),
        Spacer(),
        Text(
          itemQuantity.res.quantity.toString() +
              (itemQuantity.res.type.index == 0 ? ' L' : ' Kg'),
          style: TextStyle(
            color: isValid ? kMainColorAccent : kErrorColor,
            fontSize: getProportionateScreenWidth(11),
          ),
        ),
      ],
    );
  }
}
