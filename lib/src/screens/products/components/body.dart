import 'package:flutter/material.dart';
import 'package:inventory_management/src/widgets/paddings.dart';
import 'package:inventory_management/src/widgets/staggered_animations.dart';
import 'package:inventory_management/src/widgets/text_widgets.dart';
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
          return StaggeredGridView(
            count: snapshot.data.length + 1,
            child: (index) {
              if (index < snapshot.data.length) {
                return GridViewCard(product: snapshot.data[index]);
              } else {
                return GridViewAddCard();
              }
            },
          );
        },
      ),
    );
  }
}

class GridViewAddCard extends StatelessWidget {
  const GridViewAddCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        EditProductScreen.routeName,
        arguments: ScreenArgumentsProduct(null),
      ),
      child: Card(
        elevation: 8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add Product',
              style: Theme.of(context).textTheme.headline5.copyWith(
                    fontSize: getProportionateScreenWidth(25),
                  ),
            ),
            Icon(
              Icons.add_circle,
              size: getProportionateScreenWidth(50),
            ),
          ],
        ),
      ),
    );
  }
}

class GridViewCard extends StatelessWidget {
  const GridViewCard({
    Key key,
    this.product,
  }) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Padding(
        padding: EdgeInsets.all(
          getProportionateScreenWidth(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cardHeadlineMedium(product.name, context),
            smallPadding(),
            Text(
              'Required Resources:',
              style: Theme.of(context).textTheme.headline4.copyWith(
                    fontSize: getProportionateScreenWidth(15),
                  ),
            ),
            smallPadding(),
            ...List.generate(
              product.resources.length,
              (index) => Row(
                children: [
                  Text(
                    product.resources[index].res.name,
                    style: Theme.of(context).textTheme.headline2.copyWith(
                          fontSize: getProportionateScreenWidth(15),
                        ),
                  ),
                  Spacer(),
                  Text(
                    getQuantityTypeString(product.resources[index].res),
                    style: Theme.of(context).textTheme.headline2.copyWith(
                          fontSize: getProportionateScreenWidth(15),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
