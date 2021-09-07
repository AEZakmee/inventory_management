import 'package:flutter/cupertino.dart';
import 'package:inventory_management/src/model/resource.dart';
import '../services/firestore_service.dart';

class ResourceProvider extends ChangeNotifier {
  var _db = FirestoreService();
  void deleteResource(Resource resource) async {
    _db.deleteResource(resource);
  }
}
