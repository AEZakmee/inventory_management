import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_management/src/model/log.dart';
import 'package:inventory_management/src/model/prev_order.dart';
import 'package:inventory_management/src/model/product.dart';
import 'package:inventory_management/src/model/resource.dart';
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

  Future<void> addUser(AppUser user) {
    logToFirestore('New user registered: ${user.name}');
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

  Future<Product> fetchProduct(String resourceId) {
    return _db
        .collection('products')
        .doc(resourceId)
        .get()
        .then((value) => Product.fromJson(value.data()))
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

  Stream<List<Log>> getPrevLogs() {
    return _db
        .collection('logs')
        .orderBy("createdAt", descending: true)
        .limit(10)
        .snapshots()
        .map((event) => event.docs)
        .map((event) => event.map((e) => Log.fromJson(e.data())).toList());
  }

  Future<List<Product>> getProductsFuture() {
    return _db.collection('products').get().then(
        (value) => value.docs.map((e) => Product.fromJson(e.data())).toList());
  }

  Future<List<Resource>> getResourcesFuture() {
    return _db.collection('resources').get().then(
        (value) => value.docs.map((e) => Resource.fromJson(e.data())).toList());
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

  Future<int> getVersionNumber() {
    return _db
        .collection('version')
        .doc('version')
        .get()
        .then((value) => value['currentVersion']);
  }

  Future<bool> resourceExists(Resource resource) async {
    return await _docExists('resources', resource.name);
  }

  Future<bool> productExists(Product product) async {
    return await _docExists('products', product.name);
  }

  Future<void> addResource(Resource resource) {
    logToFirestore(
        'Added new resource: ${resource.name}, amount ${resource.quantity}');
    return _db
        .collection('resources')
        .doc(resource.uniqueID)
        .set(resource.toMap())
        .onError((error, stackTrace) => throw new AddException());
  }

  Future<void> updateResource(Resource resource) async {
    logToFirestore('Updated resource: ${resource.name}');
    Resource res = await fetchResource(resource.uniqueID);
    if (res.name != resource.name || res.quantity != resource.quantity) {
      await _db
          .collection('resources')
          .doc(resource.uniqueID)
          .update(resource.toMap())
          .onError((error, stackTrace) => throw new AddException());
      if (res.name != resource.name) {
        List<Product> products = await getProductsFuture();
        if (products != null) {
          products.forEach((element) {
            bool hasElements = false;
            for (int i = 0; i < element.resources.length; i++) {
              if (element.resources[i].res.uniqueID == resource.uniqueID) {
                hasElements = true;
                element.resources[i].res.name = resource.name;
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
    }
  }

  Future<void> deleteResource(Resource resource) async {
    logToFirestore('Deleted resource: ${resource.name}');
    List<Product> products = await getProductsFuture();
    _db.collection('resources').doc(resource.uniqueID).delete();
    if (products != null) {
      products.forEach((element) {
        bool hasElements = false;
        for (int i = 0; i < element.resources.length; i++) {
          if (element.resources[i].res.uniqueID == resource.uniqueID) {
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

  Future<void> proceedProduct(Product product, int count) async {
    await logPrevOrder(product, count);
    List<Resource> resources = await getResourcesFuture();
    product.totalOrdered += count;
    await _db
        .collection('products')
        .doc(product.uniqueID)
        .update(product.toMap());
    if (resources != null) {
      resources.forEach((res) {
        product.resources.forEach((prod) async {
          if (prod.res.uniqueID == res.uniqueID) {
            res.quantity -= count * prod.res.quantity;
            res.totalUsed += count * prod.res.quantity;
            await _db
                .collection('resources')
                .doc(res.uniqueID)
                .update(res.toMap());
          }
        });
      });
    }
  }

  Future<void> topUpResource(Resource resource, int count) {
    logToFirestore('Top up resource: ${resource.name}, amount: $count');
    resource.quantity += count;
    return _db
        .collection('resources')
        .doc(resource.uniqueID)
        .update(resource.toMap())
        .onError((error, stackTrace) => throw new AddException());
  }

  Future<void> deleteProduct(Product product) {
    logToFirestore('Deleted product: ${product.name}');
    return _db.collection('products').doc(product.uniqueID).delete();
  }

  Future<void> addProduct(Product product) {
    logToFirestore('Added new product: ${product.name}');
    return _db
        .collection('products')
        .doc(product.uniqueID)
        .set(product.toMap())
        .onError((error, stackTrace) => throw new AddException());
  }

  Future<void> updateProduct(Product product) {
    logToFirestore('Updated product: ${product.name}');
    return _db
        .collection('products')
        .doc(product.uniqueID)
        .update(product.toMap())
        .onError((error, stackTrace) => throw new AddException());
  }

  Future<void> switchFavouriteProduct(Product product) {
    return _db
        .collection('products')
        .doc(product.uniqueID)
        .update(product.toMap())
        .onError((error, stackTrace) => throw new AddException());
  }

  Future<void> switchFavouriteResource(Resource resource) {
    return _db
        .collection('resources')
        .doc(resource.uniqueID)
        .update(resource.toMap())
        .onError((error, stackTrace) => throw new AddException());
  }

  Future<void> logToFirestore(String log) {
    Log sLog = Log(
      employee: UserProvider().currentUser != null
          ? UserProvider().currentUser.name
          : 'New user',
      log: log,
      dateTime: DateTime.now(),
    );
    return _db
        .collection('logs')
        .doc(Timestamp.now().seconds.toString())
        .set(sLog.toMap())
        .onError((error, stackTrace) => throw new AddException());
  }

  Future<void> logPrevOrder(Product product, int count) {
    Log sLog = Log(
      employee: UserProvider().currentUser.name,
      log: 'Proceed product: ${product.name}, total amount: $count',
      dateTime: DateTime.now(),
    );
    PrevOrder prevOrder = PrevOrder(
        createdAt: sLog.dateTime,
        log: sLog,
        product: product,
        count: count,
        uniqueId: Uuid().v4());
    return _db
        .collection('prevOrders')
        .doc(prevOrder.uniqueId)
        .set(prevOrder.toMap())
        .onError((error, stackTrace) => throw new AddException());
  }

  Stream<List<PrevOrder>> getPrevOrders() {
    return _db
        .collection('prevOrders')
        .orderBy('createdAt', descending: true)
        .limit(10)
        .snapshots()
        .map((event) => event.docs)
        .map(
            (event) => event.map((e) => PrevOrder.fromJson(e.data())).toList());
  }

  Future<void> undoPrevOrder(PrevOrder prevOrder) async {
    List<Resource> resources = await getResourcesFuture();
    Product productUpd = await fetchProduct(prevOrder.product.uniqueID);
    productUpd.totalOrdered -= prevOrder.count;
    await _db
        .collection('products')
        .doc(productUpd.uniqueID)
        .update(productUpd.toMap());
    if (resources != null) {
      resources.forEach((res) {
        prevOrder.product.resources.forEach((prod) async {
          if (prod.res.uniqueID == res.uniqueID) {
            res.quantity += prevOrder.count * prod.res.quantity;
            res.totalUsed -= prevOrder.count * prod.res.quantity;
            await _db
                .collection('resources')
                .doc(res.uniqueID)
                .update(res.toMap());
          }
        });
      });
    }
    return _db.collection('prevOrders').doc(prevOrder.uniqueId).delete();
  }
}

class FetchException implements Exception {
  String errMsg() => 'Something went wrong fetching the resource';
}

class AddException implements Exception {
  String errMsg() => 'Something went wrong adding the resource';
}
