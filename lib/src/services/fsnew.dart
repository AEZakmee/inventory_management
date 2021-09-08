import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_management/src/services/firestore_service.dart';
import '../model/log.dart';
import '../model/prev_order.dart';
import '../model/product.dart';
import '../model/resource.dart';
import 'package:inventory_management/src/providers/user_provider.dart';
import 'package:uuid/uuid.dart';
import '../model/user.dart';

class FirestoreService {
  static final FirestoreService _singleton = FirestoreService._internal();
  factory FirestoreService() {
    return _singleton;
  }
  FirestoreService._internal();

  FirebaseFirestore _db = FirebaseFirestore.instance;

  //User
  Future<void> addUser(AppUser user) {
    return _db
        .collection('users')
        .doc(user.userId)
        .set(
          user.toMap(),
        )
        .onError(
          (error, stackTrace) => throw WriteException(errorCaller: 'AddUser'),
        );
  }

  Future<AppUser> fetchUser(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .get()
        .then((value) => AppUser.fromJson(value.data()))
        .onError(
          (error, stackTrace) => throw ReadException(errorCaller: 'FetchUser'),
        );
  }

  Stream<AppUser> userStream(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((event) => AppUser.fromJson(event.data()));
  }

  //Resource
  Future<Resource> fetchResource(String resourceId) {
    return _db
        .collection('resources')
        .doc(resourceId)
        .get()
        .then((value) => Resource.fromJson(value.data()))
        .onError(
          (error, stackTrace) =>
              throw new ReadException(errorCaller: 'fetchResource'),
        );
  }

  Future<void> addResource(Resource resource) {
    return _db
        .collection('resources')
        .doc(resource.uniqueID)
        .set(resource.toMap())
        .onError(
          (error, stackTrace) =>
              throw WriteException(errorCaller: 'addResource'),
        );
  }

  Future<List<Resource>> resourcesFuture() {
    return _db
        .collection('resources')
        .get()
        .then((value) =>
            value.docs.map((e) => Resource.fromJson(e.data())).toList())
        .onError(
          (error, stackTrace) =>
              throw new ReadException(errorCaller: 'resourcesFuture'),
        );
  }

  Stream<List<Resource>> resourcesStream() {
    return _db
        .collection('resources')
        .snapshots()
        .map((query) => query.docs)
        .map((snapshot) =>
            snapshot.map((doc) => Resource.fromJson(doc.data())).toList());
  }

  //Product
  Future<Product> fetchProduct(String productId) {
    return _db
        .collection('products')
        .doc(productId)
        .get()
        .then((value) => Product.fromJson(value.data()))
        .onError(
          (error, stackTrace) =>
              throw ReadException(errorCaller: 'fetchProduct'),
        );
  }

  Future<List<Product>> productsFuture() {
    return _db
        .collection('products')
        .get()
        .then((value) =>
            value.docs.map((e) => Product.fromJson(e.data())).toList())
        .onError(
          (error, stackTrace) =>
              throw ReadException(errorCaller: 'productsFuture'),
        );
  }

  Stream<List<Product>> productsStream() {
    return _db
        .collection('products')
        .snapshots()
        .map((event) => event.docs)
        .map((event) => event.map((e) => Product.fromJson(e.data())).toList());
  }

  //Utilities
  Future<int> getVersionNumber() {
    return _db
        .collection('version')
        .doc('version')
        .get()
        .then((value) => value['currentVersion']);
  }

  Future<bool> resourceNameExists(Resource resource) {
    return _nameUsed('resources', resource.name);
  }

  Future<bool> productNameExists(Product product) {
    return _nameUsed('products', product.name);
  }

  //Private
  Future<bool> _nameUsed(String collection, String name) async {
    var snapshots = await _db
        .collection(collection)
        .where("name", isEqualTo: name)
        .limit(1)
        .get();
    if (snapshots.docs.length == 1) return true;
    return false;
  }

  //Transactions
  Future<bool> updateResource(Resource resource) async {
    try {
      Resource resourceData = await fetchResource(resource.uniqueID);
      if (resourceData.name == resource.name &&
          resourceData.quantity == resource.quantity)
        throw TransException(error: 'Resource is the same');
      List<Product> allProducts = await productsFuture();

      await _db.runTransaction((transaction) async {
        var resourceReference =
            _db.collection('resources').doc(resource.uniqueID);
        transaction.update(resourceReference, resource.toMap());

        if (allProducts != null) {
          allProducts.forEach((element) {
            bool hasElements = false;
            for (int i = 0; i < element.resources.length; i++) {
              if (element.resources[i].res.uniqueID == resource.uniqueID) {
                hasElements = true;
                element.resources[i].res.name = resource.name;
              }
            }
            if (hasElements) {
              var updateProductReference =
                  _db.collection('products').doc(element.uniqueID);
              transaction.update(updateProductReference, element.toMap());
            }
          });
        }
      });
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  Future<bool> deleteResource(Resource resource) async {
    try {
      List<Product> allProducts = await productsFuture();
      await _db.runTransaction((transaction) async {
        var resourceReference =
            _db.collection('resources').doc(resource.uniqueID);
        transaction.delete(resourceReference);

        if (allProducts != null) {
          allProducts.forEach((element) {
            bool hasElements = false;
            for (int i = 0; i < element.resources.length; i++) {
              if (element.resources[i].res.uniqueID == resource.uniqueID) {
                hasElements = true;
                element.resources[i].isValid = false;
              }
            }
            if (hasElements) {
              var updateProductReference =
                  _db.collection('products').doc(element.uniqueID);
              transaction.update(updateProductReference, element.toMap());
            }
          });
        }
      });
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  Future<bool> proceedProduct(Product product, int count) async {
    try {
      await _db.runTransaction((transaction) async {
        var productReference = _db.collection('products').doc(product.uniqueID);
        product.totalOrdered += count;
        transaction.update(productReference, product.toMap());

        product.resources.forEach((element) async {
          if (!element.isValid)
            throw TransException(error: 'Resource is not valid');
          var resourceReference =
              _db.collection('resources').doc(element.res.uniqueID);
          Resource res = await transaction
              .get(resourceReference)
              .then((value) => Resource.fromJson(value.data()));
          res.quantity -= element.res.quantity * count;
          res.totalUsed += element.res.quantity * count;
          transaction.update(resourceReference, res.toMap());
        });
      });
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }
}

class ReadException implements Exception {
  String errorCaller;
  ReadException({this.errorCaller});
  String errMsg() =>
      'Something went wrong with fetching the data - ' + errorCaller;
}

class WriteException implements Exception {
  String errorCaller;
  WriteException({this.errorCaller});
  String errMsg() =>
      'Something went wrong with writing the data - ' + errorCaller;
}

class TransException implements Exception {
  String error;
  TransException({this.error});
  String errMsg() => 'Transaction exception ' + error;
}
