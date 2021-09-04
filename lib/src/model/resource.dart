class Resource {
  String uniqueID;
  String name;
  ResourceType type;
  double quantity;
  double totalUsed;

  Resource(
      {this.uniqueID, this.name, this.type, this.quantity, this.totalUsed = 0});

  factory Resource.fromJson(Map<String, dynamic> json) {
    return Resource(
      uniqueID: json['uniqueID'],
      name: json['name'],
      type: ResourceType.values[json['type']],
      quantity: json['quantity'],
      totalUsed: json['totalUsed'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uniqueID': uniqueID,
      'name': name,
      'type': type.index,
      'quantity': quantity,
      'totalUsed': totalUsed,
    };
  }
}

enum ResourceType {
  Litres,
  Kilos,
}
