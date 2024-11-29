import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/ingredient_provider.dart';
import 'routes.dart';
import 'themes/theme_data.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => IngredientProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Fridge App',
      theme: appTheme,
      initialRoute: '/',
      routes: routes,
    );
  }
}
