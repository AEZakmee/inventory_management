import 'package:flutter/material.dart';
import 'package:inventory_management/src/widgets/bottom_sheet.dart';
import 'package:inventory_management/src/widgets/paddings.dart';
import 'package:inventory_management/src/widgets/staggered_animations.dart';
import 'package:inventory_management/src/widgets/text_widgets.dart';
import '../../../model/product.dart';
import '../../../providers/products_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../screens/edit_product/edit_product_screen.dart';
import '../../../size_config.dart';
import '../../../widgets/pass_argument.dart';
import '../../../widgets/utilities.dart';
import 'package:provider/provider.dart';

class ProductsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductsProvider(),
      child: StreamBuilder<List<Product>>(
        stream: Provider.of<MainProvider>(context).listProducts,
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
    return InkWell(
      onTap: () => showModalBottomSheet(
          context: context,
          builder: (context) {
            return BottomSheetCustomProduct(
              product: product,
            );
          }),
      child: Card(
        elevation: 8,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: getProportionateScreenWidth(115),
                      child: cardHeadlineMedium(product.name, context),
                    ),
                    Spacer(),
                    PopupMenuButton(
                      padding: EdgeInsets.all(0),
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(value: 'edit', child: Text('Edit')),
                          product.isFavourite ?? false
                              ? PopupMenuItem(
                                  value: 'fav', child: Text('Unfavorite'))
                              : PopupMenuItem(
                                  value: 'fav',
                                  child: Text('Add to Favorites')),
                          PopupMenuItem(
                              value: 'proceed', child: Text('Proceed Order')),
                        ];
                      },
                      onSelected: (String value) {
                        switch (value) {
                          case 'edit':
                            return Navigator.pushNamed(
                              context,
                              EditProductScreen.routeName,
                              arguments: ScreenArgumentsProduct(product),
                            );
                          case 'fav':
                            Provider.of<MainProvider>(context, listen: false)
                                .switchFavourite(product: product);
                            break;
                          case 'proceed':
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return BottomSheetCustomProduct(
                                    product: product,
                                  );
                                });
                        }
                      },
                    )
                  ],
                ),
                if (product.totalOrdered != 0)
                  Row(
                    children: [
                      Text(
                        'Total ordered:',
                        style: Theme.of(context).textTheme.headline2.copyWith(
                              fontSize: getProportionateScreenWidth(15),
                            ),
                      ),
                      Spacer(),
                      Text(
                        product.totalOrdered.toInt().toString(),
                        style: Theme.of(context).textTheme.headline2.copyWith(
                              fontSize: getProportionateScreenWidth(15),
                            ),
                      ),
                    ],
                  ),
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
                      if (product.resources[index].isValid)
                        Text(
                          getQuantityTypeString(product.resources[index].res),
                          style: Theme.of(context).textTheme.headline2.copyWith(
                                fontSize: getProportionateScreenWidth(15),
                              ),
                        ),
                      if (!product.resources[index].isValid)
                        Tooltip(
                          child: Icon(Icons.error),
                          message: 'Resource has been deleted',
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
