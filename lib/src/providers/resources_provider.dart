import 'package:flutter/material.dart';
import 'package:inventory_management/src/model/resource.dart';
import 'package:inventory_management/src/model/user.dart';
import 'package:inventory_management/src/providers/user_provider.dart';
import 'package:inventory_management/src/services/firestore_service.dart';

class ResourceProvider extends ChangeNotifier {
  var _db = FirestoreService();

  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  Resource _resource;
  set resource(value) {
    _resource = value;
    nameController.text = _resource.name;
    quantityController.text = _resource.quantity.toString();
  }

  get resourceType => _resource.type;
  set resourceType(ResourceType type) {
    _resource.type = type;
    notifyListeners();
  }

  bool _hasLoadingError = false;
  get hasLoadingError => _hasLoadingError;
  set hasLoadingError(value) {
    _hasLoadingError = value;
    notifyListeners();
  }

  bool _isLoading = true;
  get isLoading => _isLoading;
  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  //Load product
  Future<void> _loadProduct(String resourceId) async {
    Resource resource;
    try {
      resource = await _db.fetchResource(resourceId);
    } on FetchException catch (e) {
      hasLoadingError = true;
      print('Error in res provider: ' + e.errMsg());
    } finally {
      this.resource = resource;
      print('resource loaded');
    }
  }

  Future<void> loadProduct() async {
    await Future.delayed(Duration(seconds: 3));
    bool isNewProduct = UserProvider().isNewItem;
    if (!isNewProduct) {
      String resourceId = UserProvider().editItemId;
      await _loadProduct(resourceId);
    } else {
      _resource = Resource();
    }
    isLoading = false;
  }

  //User input handle;
  bool _nameHasError = false;
  set nameHasError(value) {
    if (_nameHasError != value) {
      _nameHasError = value;
      notifyListeners();
    }
  }

  bool _quantityHasError = false;
  set quantityHasError(value) {
    if (_quantityHasError != value) {
      _quantityHasError = value;
      notifyListeners();
    }
  }

  void setData(String data, ResourceField field) {
    switch (field) {
      case ResourceField.Name:
        nameHasError = false;
        _resource.name = data;
        if (data.isEmpty) {
          nameHasError = true;
        }
        return;
      case ResourceField.Quantity:
        quantityHasError = false;
        try {
          double quantity = double.parse(data);
          _resource.quantity = quantity;
        } on Exception {
          quantityHasError = true;
        }
        return;
    }
  }

  bool hasError(ResourceField field) {
    switch (field) {
      case ResourceField.Name:
        return _nameHasError;
      case ResourceField.Quantity:
        return _quantityHasError;
    }
    return false;
  }

  String getError(ResourceField field) {
    switch (field) {
      case ResourceField.Name:
        return "Enter a valid name";
      case ResourceField.Quantity:
        return "Enter a valid quantity";
    }
    return "Enter a valid property";
  }
}

enum ResourceField { Name, Quantity }
