import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class ProductsProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Product> _products = [];

  List<Product> get products => _products;
  List<Product> get popularProducts => _products.where((p) => p.isPopular).toList();
  List<Product> get discountedProducts => _products.where((p) => p.isDiscounted).toList();
  List<Product> get cheapestProducts {
    var sorted = List<Product>.from(_products);
    sorted.sort((a, b) => a.price.compareTo(b.price));
    return sorted.take(5).toList();
  }

  Future<void> fetchProducts() async {
    try {
      final snapshot = await _firestore.collection('products').get();
      _products = snapshot.docs.map((doc) => Product.fromMap(doc.data(), doc.id)).toList();
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching products: $e');
      }
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      await _firestore.collection('products').add(product.toMap());
      await fetchProducts(); // Refresh the list
    } catch (e) {
      if (kDebugMode) {
        print('Error adding product: $e');
      }
    }
  }
}