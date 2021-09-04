import 'package:flutter/material.dart';
import 'package:inventory_management/src/services/firestore_service.dart';

class ProductsProvider extends ChangeNotifier {
  TextEditingController quantityController = TextEditingController();

  var _db = FirestoreService();
  void deleteProduct(String id) {
    _db.deleteProduct(id);
  }
}
