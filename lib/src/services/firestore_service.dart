import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  Stream<AppUser> userStream(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((event) => AppUser.fromJson(event.data()));
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

  Stream<List<Resource>> getResources() {
    return _db
        .collection('resources')
        .snapshots()
        .map((query) => query.docs)
        .map((snapshot) =>
            snapshot.map((doc) => Resource.fromJson(doc.data())).toList());
  }

  Stream<List<Product>> getProducts() {
    return _db
        .collection('products')
        .snapshots()
        .map((event) => event.docs)
        .map((event) => event.map((e) => Product.fromJson(e.data())).toList());
  }

  Future<List<Product>> getProductsFuture() {
    return _db.collection('products').get().then(
        (value) => value.docs.map((e) => Product.fromJson(e.data())).toList());
  }

  Future<bool> _docExists(String collection, String name) async {
    var snapshots = await _db
        .collection(collection)
        .where("name", isEqualTo: name)
        .limit(1)
        .get();
    if (snapshots.docs.length == 1) return true;
    return false;
  }

  Future<bool> resourceExists(Resource resource) async {
    return await _docExists('resources', resource.name);
  }

  Future<bool> productExists(Product product) async {
    return await _docExists('products', product.name);
  }

  Future<void> addResource(Resource resource) {
    return _db
        .collection('resources')
        .doc(resource.uniqueID)
        .set(resource.toMap())
        .onError((error, stackTrace) => throw new AddException());
  }

  Future<void> updateResource(Resource resource) {
    return _db
        .collection('resources')
        .doc(resource.uniqueID)
        .update(resource.toMap())
        .onError((error, stackTrace) => throw new AddException());
  }

  Future<void> deleteResource(String id) async {
    List<Product> products = await getProductsFuture();
    _db.collection('resources').doc(id).delete();
    if (products != null) {
      products.forEach((element) {
        bool hasElements = false;
        for (int i = 0; i < element.resources.length; i++) {
          if (element.resources[i].res.uniqueID == id) {
            hasElements = true;
            element.resources[i].isValid = false;
          }
        }
        if (hasElements) {
          _db
              .collection('products')
              .doc(element.uniqueID)
              .update(element.toMap());
        }
      });
    }
  }

  Future<void> deleteProduct(String id) {
    return _db.collection('products').doc(id).delete();
  }

  Future<void> addProduct(Product product) {
    return _db
        .collection('products')
        .doc(product.uniqueID)
        .set(product.toMap())
        .onError((error, stackTrace) => throw new AddException());
  }

  Future<void> updateProduct(Product product) {
    return _db
        .collection('products')
        .doc(product.uniqueID)
        .update(product.toMap())
        .onError((error, stackTrace) => throw new AddException());
  }
}

class FetchException implements Exception {
  String errMsg() => 'Something went wrong fetching the resource';
}

class AddException implements Exception {
  String errMsg() => 'Something went wrong adding the resource';
}
