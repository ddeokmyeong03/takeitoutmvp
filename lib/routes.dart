import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/add_ingredient_screen.dart';
import 'screens/user_screen.dart';
import 'screens/recipe_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/register_screen.dart';

Map<String, WidgetBuilder> routes = {
  '/': (context) => SplashScreen(),
  '/login': (context) => LoginScreen(),
  '/user': (context) => UserScreen(),
  '/home': (context) => HomeScreen(),
  '/register': (context) => RegisterScreen(),
  '/recipes': (context) => RecipesScreen(),
  '/settings': (context) => SettingsScreen(),
};

// 특정 `userId`를 전달해야 하는 경우에 대해 추가적으로 처리하는 함수
Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  if (settings.name == '/add_ingredient') {
    final arguments = settings.arguments as Map<String, dynamic>?;
    final userId = arguments?['userId'] ?? 0; // 기본값 설정

    return MaterialPageRoute(
      builder: (context) => AddIngredientScreen(userId: userId),
    );
  }

  return null; // 기본적으로 정의된 경로를 사용
}
