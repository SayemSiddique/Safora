import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final List<String> diets;
  final List<String> allergies;
  final List<String> healthGoals;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.diets,
    required this.allergies,
    required this.healthGoals,
  });

  factory UserModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data() ?? {};
    return UserModel(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      diets: List<String>.from(data['diets'] ?? []),
      allergies: List<String>.from(data['allergies'] ?? []),
      healthGoals: List<String>.from(data['health_goals'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'diets': diets,
      'allergies': allergies,
      'health_goals': healthGoals,
    };
  }

  UserModel copyWith({
    String? name,
    String? email,
    List<String>? diets,
    List<String>? allergies,
    List<String>? healthGoals,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      diets: diets ?? this.diets,
      allergies: allergies ?? this.allergies,
      healthGoals: healthGoals ?? this.healthGoals,
    );
  }
}
