import 'package:flutter/material.dart';
import 'package:inventory_management/src/providers/edit_product_provider.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Back"),
          ),
          TextButton(
            onPressed: () =>
                Provider.of<EditProductProvider>(context, listen: false)
                    .saveProducts(),
            child: Text("Save Products"),
          ),
        ],
      ),
    );
  }
}
