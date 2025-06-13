import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';
import '../models/user_model.dart';
import '../constants/app_constants.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch product data from OpenFoodFacts API
  Future<ProductModel?> fetchProductData(String barcode) async {
    try {
      final response = await http.get(
        Uri.parse('${AppConstants.openFoodFactsBaseUrl}$barcode.json'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 1) {
          // Product found
          final matchResults = await _analyzeProductIngredients(
            data['product']['ingredients_text'] ?? '',
          );
          return ProductModel.fromOpenFoodFacts(data, matchResults);
        }
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // Analyze product ingredients against user preferences
  Future<Map<String, bool>> _analyzeProductIngredients(
    String ingredientsText,
  ) async {
    final user = await _getCurrentUserPreferences();
    if (user == null) return {};

    final ingredients = ingredientsText.toLowerCase();
    final matchResults = <String, bool>{};

    // Check dietary restrictions
    for (final diet in user.diets) {
      final keywords = AppConstants.ingredientKeywords[diet] ?? [];
      final hasRestrictedIngredient = keywords.any(
        (keyword) => ingredients.contains(keyword.toLowerCase()),
      );
      matchResults[diet] = !hasRestrictedIngredient;
    }

    // Check allergies
    for (final allergy in user.allergies) {
      final keywords = AppConstants.ingredientKeywords['$allergy-Free'] ?? [];
      final hasAllergen = keywords.any(
        (keyword) => ingredients.contains(keyword.toLowerCase()),
      );
      matchResults[allergy] = !hasAllergen;
    }

    return matchResults;
  }

  // Get current user preferences from Firestore
  Future<UserModel?> _getCurrentUserPreferences() async {
    try {
      final userDoc = await _firestore
          .collection(AppConstants.usersCollection)
          .doc(FirebaseFirestore.instance.app.options.projectId)
          .get();

      if (!userDoc.exists) return null;
      return UserModel.fromFirestore(userDoc);
    } catch (e) {
      return null;
    }
  }

  // Save scanned product to user's history
  Future<void> saveScannedProduct(ProductModel product) async {
    try {
      final userId = FirebaseFirestore.instance.app.options.projectId;
      if (userId == null) throw 'No user logged in';

      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(userId)
          .collection(AppConstants.scannedProductsCollection)
          .add(product.toMap());
    } catch (e) {
      rethrow;
    }
  }

  // Get user's scanned products history
  Stream<List<ProductModel>> getScannedProducts() {
    try {
      final userId = FirebaseFirestore.instance.app.options.projectId;
      if (userId == null) throw 'No user logged in';

      return _firestore
          .collection(AppConstants.usersCollection)
          .doc(userId)
          .collection(AppConstants.scannedProductsCollection)
          .orderBy('scanned_at', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => ProductModel.fromFirestore(doc.data()))
            .toList();
      });
    } catch (e) {
      rethrow;
    }
  }

  // Delete a scanned product from history
  Future<void> deleteScannedProduct(String productId) async {
    try {
      final userId = FirebaseFirestore.instance.app.options.projectId;
      if (userId == null) throw 'No user logged in';

      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(userId)
          .collection(AppConstants.scannedProductsCollection)
          .doc(productId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }
} 