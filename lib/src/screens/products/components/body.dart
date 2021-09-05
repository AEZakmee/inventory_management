import 'package:flutter/material.dart';
import '../../../model/product.dart';
import '../../../providers/products_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../screens/edit_product/edit_product_screen.dart';
import '../../../size_config.dart';
import '../../../widgets/constans.dart';
import '../../../widgets/pass_argument.dart';
import '../../../widgets/utilities.dart';
import 'package:provider/provider.dart';

class ProductsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductsProvider(),
      child: StreamBuilder<List<Product>>(
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
          }),
    );
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
          color: Theme.of(context).backgroundColor,
          borderRadius: kBorderRadiusLite,
          boxShadow: [kBoxShadowLite(context)],
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
                  color: Theme.of(context).primaryColor,
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
                    color: Theme.of(context).primaryColor,
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
            color: Colors.red,
          ),
        ),
        Spacer(),
        Text(
          itemQuantity.res.quantity.toString() +
              (itemQuantity.res.type.index == 0 ? ' L' : ' Kg'),
          style: TextStyle(
            color: Colors.red,
            fontSize: getProportionateScreenWidth(11),
          ),
        ),
      ],
    );
  }
}
