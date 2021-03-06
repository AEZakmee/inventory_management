import 'package:inventory_management/src/model/resource.dart';

class Product {
  String uniqueID;
  String name;
  double totalOrdered;
  bool isFavourite;
  List<ItemQuantity> resources;

  Product(
      {this.uniqueID,
      this.name,
      this.resources,
      this.totalOrdered = 0,
      this.isFavourite = false});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      uniqueID: json['uniqueID'],
      name: json['name'],
      totalOrdered: json['totalOrdered'],
      isFavourite: json['isFavourite'],
      resources: List.from(json['resources'])
          .map((e) => ItemQuantity.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uniqueID': uniqueID,
      'name': name,
      'totalOrdered': totalOrdered,
      'isFavourite': isFavourite,
      'resources': resources.map((e) => e.toMap()).toList(),
    };
  }
}

class ItemQuantity {
  bool isValid;
  Resource res;
  ItemQuantity({this.isValid, this.res});
  factory ItemQuantity.fromJson(Map<String, dynamic> json) {
    return ItemQuantity(
      isValid: json['isValid'],
      res: Resource.fromJson(json['res']),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'isValid': isValid,
      'res': res.toMap(),
    };
  }
}
