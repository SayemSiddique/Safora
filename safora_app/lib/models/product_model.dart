class ProductModel {
  final String barcode;
  final String name;
  final String? imageUrl;
  final List<String> ingredients;
  final Map<String, bool> matchResults;
  final DateTime scannedAt;

  ProductModel({
    required this.barcode,
    required this.name,
    this.imageUrl,
    required this.ingredients,
    required this.matchResults,
    required this.scannedAt,
  });

  factory ProductModel.fromOpenFoodFacts(Map<String, dynamic> data, Map<String, bool> matchResults) {
    final product = data['product'] as Map<String, dynamic>;
    return ProductModel(
      barcode: product['code'] ?? '',
      name: product['product_name'] ?? 'Unknown Product',
      imageUrl: product['image_url'],
      ingredients: _parseIngredients(product['ingredients_text'] ?? ''),
      matchResults: matchResults,
      scannedAt: DateTime.now(),
    );
  }

  factory ProductModel.fromFirestore(Map<String, dynamic> data) {
    return ProductModel(
      barcode: data['barcode'] ?? '',
      name: data['product_name'] ?? '',
      imageUrl: data['image_url'],
      ingredients: List<String>.from(data['ingredients'] ?? []),
      matchResults: Map<String, bool>.from(data['match_result'] ?? {}),
      scannedAt: (data['scanned_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'barcode': barcode,
      'product_name': name,
      'image_url': imageUrl,
      'ingredients': ingredients,
      'match_result': matchResults,
      'scanned_at': scannedAt,
    };
  }

  static List<String> _parseIngredients(String ingredientsText) {
    if (ingredientsText.isEmpty) return [];
    
    // Split by common separators and clean up
    return ingredientsText
        .split(RegExp(r'[,;]'))
        .map((ingredient) => ingredient.trim())
        .where((ingredient) => ingredient.isNotEmpty)
        .toList();
  }

  bool isCompatible() {
    // A product is compatible if all match results are true
    return matchResults.values.every((isMatch) => isMatch);
  }

  List<String> getIncompatibleItems() {
    return matchResults.entries
        .where((entry) => !entry.value)
        .map((entry) => entry.key)
        .toList();
  }
} 