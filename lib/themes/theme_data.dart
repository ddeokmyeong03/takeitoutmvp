import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.blue, // 기본 색상 팔레트
  scaffoldBackgroundColor: Colors.white, // 앱의 기본 배경색
  appBarTheme: AppBarTheme(
    color: Colors.blue, // AppBar 배경색
    elevation: 0, // 그림자 제거
    iconTheme: IconThemeData(color: Colors.white), // AppBar 아이콘 색상
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ), // AppBar 제목 텍스트 스타일
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontSize: 16,
      color: Colors.black87,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: Colors.black54,
    ),
    displayLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    displayMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ), // 버튼 텍스트 스타일
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue, // 버튼 배경색
      foregroundColor: Colors.white, // 버튼 텍스트 색상
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // 둥근 모서리
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: Colors.blue,
      ),
    ),
    labelStyle: TextStyle(
      fontSize: 14,
      color: Colors.black54,
    ),
    hintStyle: TextStyle(
      fontSize: 12,
      color: Colors.grey,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.blue, // FAB 배경색
    foregroundColor: Colors.white, // FAB 아이콘 색상
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white, // 바 배경색
    selectedItemColor: Colors.blue, // 선택된 아이템 색상
    unselectedItemColor: Colors.grey, // 선택되지 않은 아이템 색상
    selectedLabelStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 12,
    ),
  ),
);
