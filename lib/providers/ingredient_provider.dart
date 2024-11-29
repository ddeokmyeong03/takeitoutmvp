import 'package:flutter/material.dart';

class Ingredient {
  final String name;
  final String storage;
  final String expiryDate;

  Ingredient({
    required this.name,
    required this.storage,
    required this.expiryDate,
  });
}

class IngredientProvider with ChangeNotifier {
  List<Ingredient> _ingredients = [];

  List<Ingredient> get ingredients => _ingredients;

  void addIngredient(Ingredient ingredient) {
    _ingredients.add(ingredient);
    notifyListeners(); // 상태 변경 알림
  }
}
