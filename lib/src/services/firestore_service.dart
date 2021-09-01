import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_management/src/model/product.dart';
import 'package:inventory_management/src/model/resource.dart';
import '../model/user.dart';

class FirestoreService {
  static final FirestoreService _singleton = FirestoreService._internal();

  factory FirestoreService() {
    return _singleton;
  }

  FirestoreService._internal();

  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUser(AppUser user) {
    return _db.collection('users').doc(user.userId).set(user.toMap());
  }

  Future<AppUser> fetchUser(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .get()
        .then((value) => AppUser.fromJson(value.data()));
  }

  Future<Resource> fetchResource(String resourceId) {
    return _db
        .collection('resources')
        .doc(resourceId)
        .get()
        .then((value) => Resource.fromJson(value.data()))
        .onError((error, stackTrace) {
      throw new FetchException();
    });
  }

  Future<bool> _docExists(String collection, String name) async {
    _db.collection(collection).where(name).limit(1).get().then((value) {
      if (value.size == 1) {
        return true;
      } else {
        return false;
      }
    }).onError((error, stackTrace) {
      print(error);
      return false;
    });
    return false;
  }

  Future<bool> resourceExists(Resource resource) {
    return _docExists('resources', resource.name);
  }

  Future<bool> productExists(Product product) {
    return _docExists('products', product.name);
  }

  Future<void> addResource(Resource resource) {
    return _db
        .collection('resources')
        .doc(resource.uniqueID)
        .set(resource.toMap());
  }

  Future<void> addProduct(Product product) {
    return _db
        .collection('products')
        .doc(product.uniqueID)
        .set(product.toMap());
  }
}

class FetchException implements Exception {
  String errMsg() => 'Something went wrong fetching the resource';
}
