import 'dart:convert';
import 'package:http/http.dart' as http;

class IngredientService {
  static const String baseUrl = 'http://127.0.0.1:5000';

  // 식재료 추가
  Future<String> addIngredient({
    required String name,
    required String storage,
    required String expiryDate,
    required int userId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/ingredients/add'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'storage': storage,
          'expiry_date': expiryDate,
          'user_id': userId,
        }),
      );

      if (response.statusCode == 201) {
        return "식재료가 성공적으로 추가되었습니다.";
      } else {
        final error = jsonDecode(response.body)['message'];
        return "식재료 추가 실패: $error";
      }
    } catch (e) {
      print("식재료 추가 요청 중 오류 발생: $e");
      return "식재료 추가 요청 실패";
    }
  }

  // 사용자별 식재료 가져오기
  Future<List<Map<String, dynamic>>> fetchIngredients(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/ingredients?user_id=$userId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['ingredients'];
        return List<Map<String, dynamic>>.from(data);
      } else {
        print("식재료 가져오기 실패: ${response.body}");
        return [];
      }
    } catch (e) {
      print("식재료 가져오기 요청 중 오류 발생: $e");
      return [];
    }
  }
}
