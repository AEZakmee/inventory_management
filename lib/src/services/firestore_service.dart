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

  Future<void> addProduct(Product product) {
    return _db
        .collection('products')
        .doc(product.uniqueID)
        .set(product.toMap())
        .onError((error, stackTrace) => throw new AddException());
  }
}

class FetchException implements Exception {
  String errMsg() => 'Something went wrong fetching the resource';
}

class AddException implements Exception {
  String errMsg() => 'Something went wrong adding the resource';
}
