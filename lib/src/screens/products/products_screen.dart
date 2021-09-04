import 'package:flutter/material.dart';
import '../../widgets/pass_argument.dart';
import '../../widgets/text_widgets.dart';
import '../../screens/edit_product/edit_product_screen.dart';
import '../../widgets/app_bar.dart';
import '../../styles/colors.dart';
import '../../providers/products_provider.dart';
import 'package:provider/provider.dart';
import '../../size_config.dart';
import 'components/body.dart';

class ProductsScreen extends StatefulWidget {
  static const String routeName = '/products';

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ChangeNotifierProvider(
      create: (_) => ProductsProvider(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Body(),
        appBar: buildAppBar(context: context, title: 'Products'),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(
              context,
              EditProductScreen.routeName,
              arguments: ScreenArgumentsProduct(null),
            );
          },
          backgroundColor: kMainColorAccent,
          label: buttonText(text: 'Add Product'),
          icon: Icon(
            Icons.add,
            color: kBackgroundColor,
            size: getProportionateScreenHeight(30),
          ),
        ),
      ),
    );
  }
}
