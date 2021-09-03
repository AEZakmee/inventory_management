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

  Stream<List<Resource>> get listResources => _db.getResources();

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
