import 'package:flutter/cupertino.dart';
import '../services/firestore_service.dart';

class ResourceProvider extends ChangeNotifier {
  var _db = FirestoreService();
  void deleteResource(String id) async {
    _db.deleteResource(id);
  }
}
