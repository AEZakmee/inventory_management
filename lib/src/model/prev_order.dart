import 'package:inventory_management/src/model/product.dart';
import 'log.dart';

class PrevOrder {
  Log log;
  DateTime createdAt;
  Product product;
  int count;
  String uniqueId;
  PrevOrder(
      {this.log, this.product, this.count, this.uniqueId, this.createdAt});

  factory PrevOrder.fromJson(Map<String, dynamic> json) {
    return PrevOrder(
        log: Log.fromJson(json['log']),
        product: Product.fromJson(json['product']),
        count: json['count'],
        uniqueId: json['uniqueId']);
  }

  Map<String, dynamic> toMap() {
    return {
      'log': log.toMap(),
      'product': product.toMap(),
      'count': count,
      'uniqueId': uniqueId,
      'createdAt': createdAt,
    };
  }
}
