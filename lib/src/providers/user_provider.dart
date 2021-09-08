import 'dart:async';
import 'dart:math';

import 'package:inventory_management/src/model/log.dart';
import 'package:inventory_management/src/model/prev_order.dart';
import 'package:inventory_management/src/model/product.dart';
import 'package:inventory_management/src/model/resource.dart';

import '../services/firestore_service.dart';

import '../model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {
  MainProvider._privateConstructor();
  static final MainProvider _instance = MainProvider._privateConstructor();
  factory MainProvider() {
    return _instance;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _db = FirestoreService();

  AppUser _currentUser;
  AppUser get currentUser => _currentUser;
  set currentUser(AppUser user) {
    _currentUser = user;
    notifyListeners();
  }

  void switchFavourite({Resource resource, Product product}) {
    if (resource != null) {
      if (resource.isFavourite == null) resource.isFavourite = false;
      resource.isFavourite = !resource.isFavourite;
      _db.switchFavouriteResource(resource);
    } else if (product != null) {
      if (product.isFavourite == null) product.isFavourite = false;
      product.isFavourite = !product.isFavourite;
      _db.switchFavouriteProduct(product);
    }
    notifyListeners();
  }

  Stream<List<Resource>> get listResources => _db.getResources();
  Stream<List<Product>> get listProducts => _db.getProducts();
  Stream<List<Log>> get previousLogs => _db.getPrevLogs();
  Stream<List<PrevOrder>> get prevOrders => _db.getPrevOrders();

  Stream<List<Resource>> get listResourcesFav {
    return listResources.first
        .then((value) => value.where((e) => e.isFavourite == true).toList())
        .asStream();
  }

  Stream<List<Product>> get listProductFav {
    return listProducts.first
        .then((value) => value.where((e) => e.isFavourite == true).toList())
        .asStream();
  }

  Future<int> getMaxProducts(Product product) async {
    List<Resource> resourcess = await listResources.first;
    int maxValue = 1000000;
    resourcess.forEach((resource) {
      product.resources.forEach((element) {
        if (element.res.uniqueID == resource.uniqueID) {
          maxValue =
              min(maxValue, (resource.quantity / element.res.quantity).floor());
        }
      });
    });
    return maxValue;
  }

  Future<void> proceedOrder(Product product, int count) async {
    return await _db.proceedProduct(product, count);
  }

  Future<void> revertOrder(PrevOrder prevOrder) async {
    return await _db.undoPrevOrder(prevOrder);
  }

  Future<void> topUpResource(Resource resource, int count) async {
    return await _db.topUpResource(resource, count);
  }

  Future<int> getVersion() async {
    return await _db.getVersionNumber();
  }

  Future<bool> isLoggedIn() async {
    var firebaseUser = _auth.currentUser;
    if (firebaseUser == null) return false;
    var user = await _db.fetchUser(firebaseUser.uid);
    if (user == null) return false;
    currentUser = user;
    print(currentUser.name + " is signed in");
    return true;
  }

  logout() async {
    await _auth.signOut();
    _currentUser = null;
  }
}

class CartItem {
  Product product;
  int quantity;
  CartItem({this.product, this.quantity});
}
