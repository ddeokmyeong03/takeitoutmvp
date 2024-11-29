import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/add_ingredient_screen.dart';
import 'screens/user_screen.dart';
import 'screens/recipe_screen.dart';
import 'screens/settings_screen.dart';

Map<String, WidgetBuilder> routes = {
  '/': (context) => SplashScreen(),
  '/login': (context) => LogInScreen(),
  '/user': (context) => UserScreen(),
  '/home': (context) => HomeScreen(),
  '/recipes': (context) => RecipesScreen(),
  '/settings': (context) => SettingsScreen(),
  '/add_ingredient': (context) => AddIngredientScreen(),
};
