class Product {
  String uniqueID;
  String name;
  List<ItemQuantity> resources;
  String picturePath;

  Product({this.uniqueID, this.name, this.resources, this.picturePath});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      uniqueID: json['uniqueID'],
      name: json['name'],
      resources: List.from(json['resources'])
          .map((e) => ItemQuantity.fromJson(e))
          .toList(),
      picturePath: json['picturePath'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uniqueID': uniqueID,
      'name': name,
      'resources': resources.map((e) => e.toMap()).toList(),
      'picturePath': picturePath,
    };
  }
}

class ItemQuantity {
  String id;
  String name;
  int quantity;
  ItemQuantity({this.id, this.name, this.quantity});
  factory ItemQuantity.fromJson(Map<String, dynamic> json) {
    return ItemQuantity(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
    };
  }
}
