import 'package:flutter/material.dart';
import 'package:inventory_management/src/providers/products_provider.dart';
import 'package:inventory_management/src/screens/edit_product/edit_product_screen.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: Text('asd'),
        onPressed: () {
          Provider.of<ProductsProvider>(context, listen: false)
              .printResources();
        },
      ),
    );
  }
}
