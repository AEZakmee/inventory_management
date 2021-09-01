class Resource {
  String uniqueID;
  String name;
  ResourceType type;
  double quantity;

  Resource({this.uniqueID, this.name, this.type, this.quantity});

  factory Resource.fromJson(Map<String, dynamic> json) {
    return Resource(
      uniqueID: json['uniqueID'],
      name: json['name'],
      type: ResourceType.values[json['type']],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uniqueID': uniqueID,
      'name': name,
      'type': type.index,
      'quantity': quantity,
    };
  }
}

enum ResourceType {
  Litres,
  Kilos,
}
