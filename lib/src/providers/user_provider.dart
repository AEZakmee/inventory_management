import 'dart:async';

import 'package:inventory_management/src/model/log.dart';
import 'package:inventory_management/src/model/product.dart';
import 'package:inventory_management/src/model/resource.dart';

import '../services/firestore_service.dart';

import '../model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserProvider._privateConstructor();
  static final UserProvider _instance = UserProvider._privateConstructor();
  factory UserProvider() {
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

  List<CartItem> _cart = [];
  List<CartItem> get cart => _cart;
  void addToCard({Product product, int quantity}) {
    _cart.add(CartItem(product: product, quantity: quantity));
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
