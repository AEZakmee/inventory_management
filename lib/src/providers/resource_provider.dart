import 'package:flutter/cupertino.dart';
import '../services/firestore_service.dart';

class ResourceProvider extends ChangeNotifier {
  var _db = FirestoreService();
  void deleteResource(String id) {
    _db.deleteResource(id);
  }
}
