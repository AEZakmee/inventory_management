import 'package:flutter/material.dart';
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
      ),
    );
  }
}
