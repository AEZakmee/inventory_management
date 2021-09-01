import 'package:flutter/material.dart';
import 'package:inventory_management/src/model/resource.dart';
import 'package:inventory_management/src/services/firestore_service.dart';
import 'package:uuid/uuid.dart';
import '../model/product.dart';

class EditProductProvider extends ChangeNotifier {
  Product _currentProduct;
  var _db = FirestoreService();

  get productId => _currentProduct.uniqueID;
  get productName => _currentProduct.name;
  get productResources => _currentProduct.resources;
  get productImage => _currentProduct.picturePath;

  Resource res1 = Resource(
    quantity: 100,
    name: 'sugar',
    type: ResourceType.Kilos,
    uniqueID: Uuid().v4(),
  );
  Resource res2 = Resource(
    quantity: 300,
    name: 'milk',
    type: ResourceType.Litres,
    uniqueID: Uuid().v4(),
  );
  Product product1 = Product(
    uniqueID: Uuid().v4(),
    name: 'shokolad',
    picturePath: 'none',
    resources: [
      ItemQuantity(quantity: 20, id: 'aasd'),
      ItemQuantity(id: 'asdsdddd', quantity: 34),
    ],
  );
  Product product2 = Product(
    uniqueID: Uuid().v4(),
    name: 'shokolad4',
    picturePath: 'none',
    resources: [
      ItemQuantity(quantity: 20, id: 'asd'),
      ItemQuantity(id: 'ad', quantity: 34),
    ],
  );
  void saveProducts() async {
    await _db.addProduct(product1);
    await _db.addProduct(product2);
    await _db.addResource(res1);
    await _db.addResource(res2);
  }
}
