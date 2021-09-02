import 'package:flutter/material.dart';
import 'package:inventory_management/src/model/resource.dart';
import 'package:inventory_management/src/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class EditResourceProvider extends ChangeNotifier {
  var _db = FirestoreService();

  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  EditResourceProvider(Resource resource) {
    if (resource == null) {
      _resource = Resource(
        type: ResourceType.Kilos,
        name: "",
        quantity: 0,
      );
    } else {
      this.resource = resource;
    }
  }
  Resource _resource;
  set resource(value) {
    _resource = value;
    nameController.text = _resource.name;
    quantityController.text = _resource.quantity.toString();
    isEdit = true;
  }

  bool isEdit = false;

  get resourceType => _resource.type;
  set resourceType(ResourceType type) {
    if (_resource.type != type) {
      _resource.type = type;
      notifyListeners();
    }
  }

  //Error handling
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
      _nameHasError ||
      _quantityHasError ||
      _resource.name.isEmpty ||
      _resource.quantity == 0;

  void addQuantity(int value) {
    _resource.quantity += value.toDouble();
    quantityController.text = _resource.quantity.toString();
  }

  //Load product
  Future<bool> saveProduct() async {
    if (hasErrors) {
      setError(value: true, error: "Please enter all the required information");
      return false;
    }
    try {
      if (!isEdit) {
        //Save new product
        Resource newRes = Resource(
          uniqueID: Uuid().v4(),
          type: _resource.type,
          quantity: _resource.quantity,
          name: _resource.name,
        );
        bool exists = await _db.resourceExists(newRes);
        if (exists) {
          setError(value: true, error: "Product with that name already exists");
          return false;
        } else {
          await _db.addResource(newRes);
          return true;
        }
      } else {
        await _db.addResource(_resource);
        return true;
      }
    } on AddException catch (e) {
      setError(value: true, error: e.errMsg());
      return false;
    }
    return false;
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
    setError(value: false);
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
