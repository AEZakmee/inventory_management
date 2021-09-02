import 'package:flutter/material.dart';
import 'package:inventory_management/src/model/resource.dart';
import 'package:inventory_management/src/providers/user_provider.dart';

class ProductsProvider extends ChangeNotifier {
  printResources() async {
    print("here");
    List<Resource> res = await UserProvider().listResources.first;
    print(res.length);
    for (int i = 0; i < res.length; i++) {
      print(res[i].name);
    }
  }
}
