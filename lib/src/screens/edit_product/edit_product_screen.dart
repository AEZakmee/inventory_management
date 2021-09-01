import 'package:flutter/material.dart';
import '../../providers/edit_product_provider.dart';
import '../../styles/colors.dart';
import 'package:provider/provider.dart';
import '../../size_config.dart';
import 'components/body.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeName = '/edit_product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ChangeNotifierProvider(
      create: (_) => EditProductProvider(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Body(),
      ),
    );
  }
}
