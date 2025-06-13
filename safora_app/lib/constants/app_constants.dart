class AppConstants {
  // API Endpoints
  static const String openFoodFactsBaseUrl =
      'https://world.openfoodfacts.org/api/v0/product/';

  // Firebase Collections
  static const String usersCollection = 'users';
  static const String scannedProductsCollection = 'scanned_products';

  // Dietary Options
  static const List<String> availableDiets = [
    'Halal',
    'Vegan',
    'Vegetarian',
    'Kosher',
    'Gluten-Free',
    'Diabetic-Friendly',
    'Low-Sodium',
    'Paleo',
    'Keto',
    'Low-Carb',
  ];

  // Allergy Options
  static const List<String> availableAllergies = [
    'Peanuts',
    'Tree Nuts',
    'Dairy',
    'Eggs',
    'Soy',
    'Wheat',
    'Shellfish',
    'Fish',
    'Sesame',
    'Gluten',
  ];

  // Health Goals
  static const List<String> availableHealthGoals = [
    'Weight Loss',
    'Heart Health',
    'Muscle Gain',
    'Energy Boost',
    'Blood Sugar Control',
    'Digestive Health',
    'Anti-Inflammatory',
    'Low Cholesterol',
  ];

  // Ingredient Keywords for Matching
  static const Map<String, List<String>> ingredientKeywords = {
    'Halal': ['pork', 'alcohol', 'gelatin', 'lard'],
    'Vegan': ['milk', 'honey', 'eggs', 'whey', 'casein', 'lactose'],
    'Vegetarian': ['meat', 'fish', 'poultry', 'gelatin'],
    'Kosher': ['pork', 'shellfish', 'mixing meat and dairy'],
    'Gluten-Free': ['wheat', 'barley', 'rye', 'malt', 'brewer\'s yeast'],
    'Dairy-Free': ['milk', 'cream', 'butter', 'whey', 'casein', 'lactose'],
    'Nut-Free': ['peanuts', 'almonds', 'cashews', 'walnuts', 'pecans'],
    'Soy-Free': ['soy', 'soya', 'soybean', 'tofu', 'edamame'],
    'Egg-Free': ['eggs', 'albumin', 'mayonnaise'],
    'Shellfish-Free': ['shrimp', 'crab', 'lobster', 'prawn', 'shellfish'],
  };

  // App Theme Colors
  static const int primaryColor = 0xFF4CAF50; // Green
  static const int secondaryColor = 0xFF81C784; // Light Green
  static const int accentColor = 0xFF2E7D32; // Dark Green
  static const int errorColor = 0xFFE57373; // Light Red
  static const int successColor = 0xFF81C784; // Light Green
  static const int warningColor = 0xFFFFB74D; // Light Orange

  // App Text Styles
  static const double headingFontSize = 24.0;
  static const double subheadingFontSize = 18.0;
  static const double bodyFontSize = 16.0;
  static const double captionFontSize = 14.0;

  // App Spacing
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;

  // App Border Radius
  static const double defaultBorderRadius = 8.0;
  static const double cardBorderRadius = 12.0;
  static const double buttonBorderRadius = 24.0;
}
