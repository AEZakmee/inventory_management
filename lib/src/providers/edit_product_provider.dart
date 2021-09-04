import 'package:flutter/material.dart';
import '../model/resource.dart';
import '../providers/user_provider.dart';
import '../services/firestore_service.dart';
import 'package:uuid/uuid.dart';
import '../model/product.dart';

class EditProductProvider extends ChangeNotifier {
  var _db = FirestoreService();
  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  EditProductProvider(Product product) {
    _loadResources();
    if (product == null) {
      _product = Product(
        name: "",
        resources: [],
      );
    } else {
      this.product = product;
    }
  }

  Product _product;
  get product => _product;
  set product(newProduct) {
    _product = newProduct;
    nameController.text = _product.name;
    isEdit = true;
    notifyListeners();
  }

  bool isEdit = false;

  bool _showErrorsString = false;
  get showErrorsString => _showErrorsString;
  String _errorsString = "";
  get errorsString => _errorsString;
  void setError({bool value, String error = ""}) {
    _errorsString = error;
    _showErrorsString = value;
    notifyListeners();
  }

  bool get hasErrors =>
      _nameHasError || _product.name.isEmpty || _product.resources.isEmpty;

  bool _nameHasError = false;
  set nameHasError(value) {
    if (_nameHasError != value) {
      _nameHasError = value;
      notifyListeners();
    }
  }

  double _quantity;
  bool _quantityHasError = false;
  set quantityHasError(value) {
    if (_quantityHasError != value) {
      _quantityHasError = value;
      notifyListeners();
    }
  }

  void setData(String data, ProductField field) {
    setError(value: false);
    switch (field) {
      case ProductField.Name:
        nameHasError = false;
        _product.name = data;
        if (data.isEmpty) {
          nameHasError = true;
        }
        return;
      case ProductField.Quantity:
        quantityHasError = false;
        try {
          double quantity = double.parse(data);
          _quantity = quantity;
        } on Exception {
          quantityHasError = true;
        }
        return;
    }
  }

  bool hasError(ProductField field) {
    switch (field) {
      case ProductField.Name:
        return _nameHasError;
      case ProductField.Quantity:
        return _quantityHasError;
    }
    return false;
  }

  String getError(ProductField field) {
    switch (field) {
      case ProductField.Name:
        return "Enter a valid name";
      case ProductField.Quantity:
        return "Not valid";
    }
    return "Not valid";
  }

  Resource _selectedResource;
  Resource get selectedResource => _selectedResource;
  set selectedResource(Resource value) {
    _selectedResource = value;
    notifyListeners();
  }

  List<Resource> _resourcesList;
  get resourcesList => _resourcesList != null
      ? _resourcesList.map<DropdownMenuItem<Resource>>((value) {
          return DropdownMenuItem<Resource>(
            value: value,
            child: Text(value.name),
          );
        }).toList()
      : null;

  void _loadResources() async {
    _resourcesList = await UserProvider().listResources.first;
    notifyListeners();
  }

  List<ItemQuantity> get resources => _product.resources;

  void deleteResource(index) {
    _product.resources.removeAt(index);
    notifyListeners();
  }

  bool appendResource() {
    if (_selectedResource != null && !_quantityHasError && _quantity != 0) {
      if (!_product.resources
          .map((e) => e.res.uniqueID)
          .contains(_selectedResource.uniqueID)) {
        var newItem = ItemQuantity(isValid: true, res: _selectedResource);
        newItem.res.quantity = _quantity;
        quantityController.text = "";
        _quantity = 0;
        _product.resources.insert(0, newItem);
        return true;
      } else {
        _product.resources
            .where(
                (element) => element.res.uniqueID == _selectedResource.uniqueID)
            .first
            .res
            .quantity = _quantity;
      }
    } else {
      quantityHasError = true;
    }
    return false;
  }

  Future<bool> saveProduct() async {
    if (hasErrors) {
      setError(value: true, error: "Please enter all the required information");
      return false;
    }
    try {
      if (!isEdit) {
        //Save new product
        Product newProd = Product(
          uniqueID: Uuid().v4(),
          name: _product.name,
          resources: _product.resources,
        );

        bool exists = await _db.productExists(newProd);
        if (exists) {
          setError(value: true, error: "Product with that name already exists");
          return false;
        } else {
          _db.addProduct(newProd);
          return true;
        }
      } else {
        _db.updateProduct(_product);
        return true;
      }
    } on AddException catch (e) {
      setError(value: true, error: e.errMsg());
      return false;
    }
  }
}

enum ProductField {
  Name,
  Quantity,
}
